import 'package:flutter/material.dart';

//テキストフォームのdecorationの定数
const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

///表示するiconsの定義
const icons = <Map<String, dynamic>>[
  {
    'emotion': 'very_dissatisfied',
    'icon': Icon(Icons.sentiment_very_dissatisfied),
  },
  {
    'emotion': 'dissatisfied',
    'icon': Icon(Icons.sentiment_dissatisfied),
  },
  {
    'emotion': 'neutral',
    'icon': Icon(Icons.sentiment_neutral),
  },
  {
    'emotion': 'satisfied',
    'icon': Icon(Icons.sentiment_satisfied),
  },
  {
    'emotion': 'very_satisfied',
    'icon': Icon(Icons.sentiment_very_satisfied),
  }
];
