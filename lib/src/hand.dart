import 'dart:math';
import 'card.dart';
import 'shoe.dart';

class Hand {
  List cards = [];
  Shoe parentShoe = Shoe.mock();

  Hand(Shoe parent) {
    parentShoe = parent;
  }
}
