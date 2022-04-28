import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuationPlay extends StatefulWidget {
  late final String option, description, correctAnswer, optionSelected;

  QuationPlay(
      {required this.description, required this.correctAnswer, required this.option, required this.optionSelected});
  @override
  State<QuationPlay> createState() => _QuationPlayState();
}

class _QuationPlayState extends State<QuationPlay> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Row(
    children: [
    Container(
    height: 28,
    width: 28,
    alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
                color: widget.optionSelected == widget.description
                    ? widget.description == widget.correctAnswer
                    ? Colors.green.withOpacity(0.7)
                    : Colors.red.withOpacity(0.7)
                    : Colors.grey,
                width: 1.5),
            color: widget.optionSelected == widget.description
                ? widget.description == widget.correctAnswer
                ? Colors.green.withOpacity(0.7)
                : Colors.red.withOpacity(0.7)
                : Colors.white,
            borderRadius: BorderRadius.circular(24)
        ),
      child: Text(
      widget.option,
      style: TextStyle(
        color: widget.optionSelected == widget.description
            ? Colors.white
            : Colors.grey,
      ),
    ),

    ),
      SizedBox(
      width: 8,
    ),
    Text(widget.description, style: TextStyle(
    fontSize: 17, color: Colors.black54
    ),)
    ],
    ),
    );

  }
}
