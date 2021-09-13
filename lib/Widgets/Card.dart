import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Column(
          children: [
            FadeInImage(
              fit: BoxFit.cover,
              image: NetworkImage(''),
              placeholder: AssetImage(''),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text('Something'),
            )
          ],
        ),
      ),
    );
  }
}
