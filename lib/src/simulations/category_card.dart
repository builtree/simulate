import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 10,
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              width: double.infinity,
              child: Image.asset(
                widget.image,
                fit: BoxFit.scaleDown,
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
