import 'dart:ui' as prefix0;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final String categoryName;
  final String image;
  CategoryCard({Key key, @required this.categoryName, @required this.image})
      : super(key: key);
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Container(
          width: MediaQuery.of(context).size.width - 20,
          child: Stack(
            children: <Widget>[
              SizedBox(
                // height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width - 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              // BackdropFilter(
              //   filter: prefix0.ImageFilter.blur(sigmaX: 2, sigmaY: 2 ),
              //   child: Container(
              //     color: Colors.black.withOpacity(0),
              //   ),
              // ),
              Center(
                child: Material(
                  elevation: 10,
                  color: Colors.transparent,
                  child: Text(
                    widget.categoryName,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
