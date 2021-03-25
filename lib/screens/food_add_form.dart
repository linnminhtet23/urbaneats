import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:urban_eats/api/food_api.dart';
import 'package:urban_eats/model/food.dart';
import 'package:urban_eats/notifier/food_notifier.dart';

class FoodAddForm extends StatefulWidget {
  final bool isUpdating;

  FoodAddForm({this.isUpdating});
  @override
  _FoodAddFormState createState() => _FoodAddFormState();
}

class _FoodAddFormState extends State<FoodAddForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Food _currentFood;
  String _imageUrl;
  File _imageFile;
  @override
  void initState() {
    super.initState();
    FoodNotifier foodNotifier =
        Provider.of<FoodNotifier>(context, listen: false);

    if (foodNotifier.currentFood != null) {
      _currentFood = foodNotifier.currentFood;
    } else {
      _currentFood = new Food();
    }

    _imageUrl = _currentFood.image;
  }

  _saveFood(context) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    uploadFoodAndImage(_currentFood, widget.isUpdating, _imageFile);
    print("name ${_currentFood.name}");
    print("category ${_currentFood.category}");
    print("_imageFile ${_imageFile.toString()}");
    print("_imageUrl $_imageUrl");
  }

  Widget _showImage() {
    if (_imageFile == null && _imageUrl == null) {
      return Text("Image placeholder");
    } else if (_imageFile != null) {
      print('Showing image from local file');
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(_imageFile, fit: BoxFit.cover, height: 250),
          FlatButton(
            padding: EdgeInsets.all(15),
            color: Colors.black54,
            child: Text(
              'Change Image',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    } else if (_imageUrl != null) {
      print('Showing imge from url');
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.network(_imageUrl, fit: BoxFit.cover, height: 250),
          FlatButton(
            padding: EdgeInsets.all(15),
            color: Colors.black54,
            child: Text(
              'Change Image',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    }
  }

  _getLocalImage() async {
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 400);
    if (imageFile != null) {
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      initialValue: _currentFood.name,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return "Name is reqiured";
        }
        return null;
      },
      onSaved: (String value) {
        _currentFood.name = value;
      },
    );
  }

  Widget _buildCategoryField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Category'),
      initialValue: _currentFood.category,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return "Category is reqiured";
        }
        return null;
      },
      onSaved: (String value) {
        _currentFood.category = value;
      },
    );
  }

  Widget _buildRestaurantField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Restaurnt Name'),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return "Restaurant Name is reqiured";
        }
        return null;
      },
      onSaved: (String value) {
        _currentFood.restaurantName = value;
      },
    );
  }

  Widget _buildPriceField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Price'),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return "Price is reqiured";
        }
        return null;
      },
      onSaved: (String value) {
        _currentFood.price = value;
      },
    );
  }

  Widget _buildDiscountField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Discount'),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        return null;
      },
      onSaved: (String value) {
        _currentFood.discount = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food Add Form')),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                _showImage(),
                SizedBox(height: 16),
                Text(
                  widget.isUpdating ? "Edit Food" : "Create Food",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 16),
                _imageFile == null && _imageUrl == null
                    ? ButtonTheme(
                        child: RaisedButton(
                          onPressed: () => _getLocalImage(),
                          child: Text(
                            "Add Image",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    : SizedBox(height: 0),
                _buildNameField(),
                _buildCategoryField(),
                _buildRestaurantField(),
                _buildPriceField(),
                _buildDiscountField(),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _saveFood(context),
        child: Icon(Icons.save),
        foregroundColor: Colors.white,
      ),
    );
  }
}
