import 'package:flutter/material.dart';

class AgendaVazia extends StatefulWidget {
  String title;
  AgendaVazia(this.title);
  @override
  _AgendaVaziaState createState() => _AgendaVaziaState();
}

class _AgendaVaziaState extends State<AgendaVazia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_sharp),
        ),
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Image.asset('assets/images/logo.png')),
      ),
    );
  }
}
