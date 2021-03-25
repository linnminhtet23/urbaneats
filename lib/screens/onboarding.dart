import 'dart:io';

import 'package:flutter/material.dart';
import 'package:urban_eats/model/obscreenelement.dart';
import 'package:urban_eats/screens/signin.dart';

class OBScreen extends StatefulWidget {
  @override
  _OBScreenState createState() => _OBScreenState();
}

class _OBScreenState extends State<OBScreen> {
  List<SliderModel> slides = new List<SliderModel>();
  int currentIndex = 0;
  PageController pageController = new PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides = getSlide();
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
          controller: pageController,
          itemCount: slides.length,
          onPageChanged: (val) {
            setState(() {
              currentIndex = val;
            });
          },
          itemBuilder: (context, index) {
            return Slider(
              slides[index].getImagePath(),
              slides[index].getTitle(),
              slides[index].getDesc(),
            );
          }),
      bottomSheet: currentIndex != slides.length - 1
          ? Container(
              height: Platform.isIOS ? 70 : 60,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      pageController.animateToPage(slides.length - 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.linear);
                    },
                    child: Text("SKIP"),
                  ),
                  Row(
                    children: <Widget>[
                      for (int i = 0; i < slides.length; i++)
                        currentIndex == i
                            ? _buildPageIndicator(true)
                            : _buildPageIndicator(false)
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      pageController.animateToPage(currentIndex + 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.linear);
                    },
                    child: Text("NEXT"),
                  ),
                ],
              ),
            )
          : GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Signin()));
              },
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: Platform.isIOS ? 70 : 60,
                  color: Colors.deepPurple[800],
                  child: Text("GET STARTED",
                      style: TextStyle(
                          fontFamily: "Montserrat", color: Colors.white))),
            ),
    );
  }
}

class Slider extends StatelessWidget {
  String imageAssetPath, title, desc;
  Slider(this.imageAssetPath, this.title, this.desc);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imageAssetPath),
          SizedBox(
            height: 20,
          ),
          Text(title),
          SizedBox(height: 20),
          Text(desc),
        ],
      ),
    );
  }
}
