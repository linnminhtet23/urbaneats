import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:urban_eats/model/restaurant.dart';
import 'package:urban_eats/notifier/restaurant_notifier.dart';
import 'package:urban_eats/api/food_api.dart';

class RestaurantAddForm extends StatefulWidget {
  //final bool isUpdating;

  //RestaurantAddForm({@required this.isUpdating});
  @override
  _RestaurantAddFormState createState() => _RestaurantAddFormState();
}

class _RestaurantAddFormState extends State<RestaurantAddForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Restaurant _currentRestaurant;
  String _imageUrl;
  File _imageFile;

  @override
  void initState() {
    super.initState();
    RestaurantNotifier restaurantNotifier =
        Provider.of<RestaurantNotifier>(context, listen: false);

    if (restaurantNotifier.currentRestaurant != null) {
      _currentRestaurant = restaurantNotifier.currentRestaurant;
    } else {
      _currentRestaurant = new Restaurant();
    }
    _imageUrl = _currentRestaurant.restaurantImage;
  }

  _saveRestaurant(context) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    uploadRestaurantAndImage(_currentRestaurant, _imageFile);
    print("name ${_currentRestaurant.restaurantName}");
    print("address ${_currentRestaurant.address} ");
    print("imageUrl $_imageUrl");
    print("imageFile ${_imageFile.toString()}");
    print("time ${_currentRestaurant.time}");
    //print("location ${_currentRestaurant.location}");
  }

  Widget _showImage() {
    if (_imageFile == null && _imageUrl == null) {
      return Text("Image placeholder");
    } else if (_imageFile != null) {
      print("Showing image from local file");
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
      initialValue: _currentRestaurant.restaurantName,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return "Name is reqiured";
        }
        return null;
      },
      onSaved: (String value) {
        _currentRestaurant.restaurantName = value;
      },
    );
  }

  Widget _buildAddressField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      initialValue: _currentRestaurant.address,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return "Name is reqiured";
        }
        return null;
      },
      onSaved: (String value) {
        _currentRestaurant.address = value;
      },
    );
  }

  Widget _buildTimeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      initialValue: _currentRestaurant.time,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return "Name is reqiured";
        }
        return null;
      },
      onSaved: (String value) {
        _currentRestaurant.time = value;
      },
    );
  }

  Widget _buildLocationField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      initialValue: _currentRestaurant.time,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return "Name is reqiured";
        }
        return null;
      },
      onSaved: (String value) {
        _currentRestaurant.time = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Add Form"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Form(
            key: _formKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                _showImage(),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Create Restaurant",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 16),
                _buildNameField(),
                _buildAddressField(),
                _buildTimeField(),
                _buildLocationField()
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _saveRestaurant(context),
        child: Icon(Icons.save),
        foregroundColor: Colors.white,
      ),
    );
  }
}
