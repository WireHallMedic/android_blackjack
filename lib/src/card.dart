import 'package:flutter/material.dart';

class PlayingCard {
  String face = "?";
  int val = 0;
  String suit = "?";

  PlayingCard.mock();

  // create a card from indexs
  PlayingCard(int pos, int s) {
    switch (pos) {
      case 0:  face = "A";  val = 11; break;
      case 1:  face = "2";  val = 2;  break;
      case 2:  face = "3";  val = 3;  break;
      case 3:  face = "4";  val = 4;  break;
      case 4:  face = "5";  val = 5;  break;
      case 5:  face = "6";  val = 6;  break;
      case 6:  face = "7";  val = 7;  break;
      case 7:  face = "8";  val = 8;  break;
      case 8:  face = "9";  val = 9;  break;
      case 9:  face = "10"; val = 10; break;
      case 10: face = "J";  val = 10; break;
      case 11: face = "Q";  val = 10; break;
      case 12: face = "K";  val = 10; break;
    }
    switch (s) {
      case 0: suit = "S"; break;
      case 1: suit = "H"; break;
      case 2: suit = "D"; break;
      case 3: suit = "C"; break;
    }
  }

  // calculating a hand that has not yet had an ace
  int getHighVal() {
    return val;
  }

  // calculating a hand that has had one or more aces
  int getLowVal() {
    if (val == 11)
      return 1;
    return val;
  }
/*
  // compare two cards
  bool compare(PlayingCard that)
  {
    return this.val == that.val;
  }*/

  // get suit-based color
  Color getColor()
  {
    if(this.suit == "H" || this.suit == "D")
      return Colors.red;
    return Colors.black;
  }

  String get string
  {
    return "$face$suit";
  }
}
