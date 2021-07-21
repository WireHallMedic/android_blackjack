//import 'dart:math';
//import 'card.dart';
import 'shoe.dart';

class Hand {
  List _cards = [];
  Shoe parentShoe = Shoe.mock();
  static final int MAX_HAND_VALUE = 21;

  // constructor; requries a shoe from which to draw
  Hand(Shoe parent) {
    parentShoe = parent;
  }

  // mock constructor
  Hand.mock() {}

  // getter for displaying cards
  List get cards => _cards;

  // draw a card
  void draw() {
    _cards.add(parentShoe.draw);
  }

  // new game; clear hand and draw two
  void newGame() {
    _cards = [];
    draw();
    draw();
  }

  // calculate value of hand
  int value() {
    int val = 0;
    bool aceFound = false;
    _cards.forEach((c) {
      val += c.getLowVal() as int;
      if (c.getHighVal() as int == 11) {
        aceFound = true;
      }
    });
    if (aceFound && val + 10 <= MAX_HAND_VALUE) val = val + 10;
    return val;
  }

  // is the hand over 21?
  bool isBusted() {
    return value() > MAX_HAND_VALUE;
  }
}
