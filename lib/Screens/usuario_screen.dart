import 'package:flutter/material.dart';
import 'package:flutter_login_basic/Globals/Global.dart';

class UsuarioScreen extends StatefulWidget {
  const UsuarioScreen({Key? key}) : super(key: key);
  @override
  _UsuarioScreenState createState() => _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  int _index = 0;
  PageController _pageController = PageController(viewportFraction: 0.7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cards'), automaticallyImplyLeading: false),
      body: Center(
        child: SizedBox(
          height: 750,
          child: PageView.builder(
            itemCount: 15,
            controller: _pageController,
            onPageChanged: (int index) => setState(() => _index = index),
            itemBuilder: (_, i) {
              return Transform.scale(
                scale: i == _index ? 1 : 0.9,
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      "Card ${i + 1}",
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
