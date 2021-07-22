//import 'dart:math';
import 'card.dart';
import 'shoe.dart';

class Hand {
  List _cards = [];
  Shoe parentShoe = Shoe.mock();
  int _value = 0;
  bool _hard = true;
  static final int MAX_HAND_VALUE = 21;

  // constructor; requries a shoe from which to draw
  Hand(Shoe parent) {
    parentShoe = parent;
  }

  // mock constructor
  Hand.mock();

  // getters
  List get cards => _cards;
  int get value => _value;
  bool get isHard => _hard;
  bool get isSoft => !_hard;
  bool get isBusted => value > MAX_HAND_VALUE;

  // draw a card
  void draw() {
    _cards.add(parentShoe.draw());
    calcValue();
  }

  // new game; clear hand and draw two
  void newGame() {
    _cards = [];
    draw();
    draw();
  }

  // calculate value of hand
  void calcValue() {
    var val = 0;
    bool aceFound = false;
    // can't use a foreach beacuse we need val and aceFound in scope
    for (int i = 0; i < _cards.length; i++) {
      val += _cards[i].getLowVal() as int;
      if (_cards[i].getHighVal() as int == 11) {
        aceFound = true;
      }
    }
    if (aceFound && val + 10 <= MAX_HAND_VALUE) {
      _value = val + 10;
      _hard = false;
    } else {
      _value = val;
      _hard = true;
    }
  }

  String get string {
    String str = "";
    for (int i = 0; i < _cards.length; i++) {
      str += _cards.elementAt(i).string;
      if (i < _cards.length - 1) str += ", ";
    }
    return str;
  }

  String get faceDownString {
    String str = "";
    if (_cards.length > 0) {
      str += _cards.elementAt(i).string;
      str += ", ";
    }
    str += "?";
    return str;
  }
}
