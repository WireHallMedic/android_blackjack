//import 'package:flutter/material.dart';
import 'dart:math';
import 'card.dart';

class Shoe {
  int _numberOfDecks = 1;
  int _reshuffleAtDecks = 1;
  List stack = [];
  Random rng = Random();
  int _gamesSinceShuffle = 0;
  static const int CARDS_IN_A_DECK = 52;

  Shoe.mock();

  Shoe(int decks, int reshufflePoint) {
    _numberOfDecks = max<int>(decks, 1);
    _reshuffleAtDecks = min<int>(decks, 1);
    shuffle();
  }

  // create a new shoe of _numberOfDecks shuffled decks
  void shuffle() {
    _gamesSinceShuffle = 0;
    stack = [];
    var _tempStack = [];
    for (int i = 0; i < _numberOfDecks; i++) {
      var deck = _getDeck();
      while (deck.isNotEmpty) {
        _tempStack.add(deck.removeAt(0));
      }
    }
    while (_tempStack.isNotEmpty) {
      var cardIndex = rng.nextInt(_tempStack.length);
      stack.add(_tempStack.removeAt(cardIndex));
    }
  }

  // get a single, unshuffled deck
  List _getDeck() {
    List deck = [];
    for (int v = 0; v < 13; v++)
      for (int s = 0; s < 4; s++) {
        deck.add(PlayingCard(v, s));
      }
    return deck;
  }

  // draw a single card
  PlayingCard draw() {
    if (stack.isEmpty) shuffle();
    return stack.removeAt(0);
  }

  // notify the deck that a game has ended
  void gameHasEnded() {
    _gamesSinceShuffle += 1;
    if (stack.length <= (CARDS_IN_A_DECK * _reshuffleAtDecks)) {
      shuffle();
    }
  }

  int get gamesSinceShuffle {
    return _gamesSinceShuffle;
  }
}
