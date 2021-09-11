import 'package:flutter/material.dart';



class DefaultButton extends StatelessWidget {

  final String text;
  final Function action;
  final size;



  DefaultButton({this.text, this.action,this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: action,
          child: Text(text,style: TextStyle(
              fontSize: size
          ),)
      ),
    );
  }
}


class DefaultTextButton extends StatelessWidget {

  final String text;
  final Function action;


  DefaultTextButton({this.text, this.action});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: action, child: Text(text));
  }
}
