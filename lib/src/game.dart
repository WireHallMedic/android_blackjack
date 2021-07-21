import 'card.dart';
import 'hand.dart';
import 'shoe.dart';

class BlackjackGame {
  Hand dealerHand = Hand.mock();
  Hand playerHand = Hand.mock();
  int _phase = -1;
  int _result = -1;
  Shoe shoe = Shoe.mock();

  static const int HARD_STAND = 17;
  static const int SOFT_STAND = 17;
  static const int PLAYER_PHASE = 0;
  static const int DEALER_PHASE = 1;
  static const int SHOWDOWN_PHASE = 2;
  static const int DEALER_WIN_BLACKJACK = 0;
  static const int PLAYER_WIN_BLACKJACK = 1;
  static const int DEALER_WIN = 2;
  static const int PLAYER_WIN = 3;
  static const int PUSH_BLACKJACK = 4;
  static const int PUSH = 5;
  static const int DEALER_WIN_BUST = 6;
  static const int PLAYER_WIN_BUST = 7;

  // constructor
  BlackjackGame(int decks, int reshufflePoint) {
    shoe = Shoe(decks, reshufflePoint);
    newGame();
  }

  // start new game
  void newGame() {
    // deal
    playerHand = Hand(shoe);
    dealerHand = Hand(shoe);
    playerHand.newGame();
    dealerHand.newGame();
    _result = -1;

    // check for automatic wins
    int blackjack_switch = 0;
    if (dealerHand.value == 21) blackjack_switch += 1;
    if (playerHand.value == 21) blackjack_switch += 2;
    switch (blackjack_switch) {
      case 0:
        // no automatic win, proceed
        _phase = PLAYER_PHASE;
        break;
      case 1:
        _phase = SHOWDOWN_PHASE;
        _result = DEALER_WIN_BLACKJACK;
        break;
      case 2:
        _phase = SHOWDOWN_PHASE;
        _result = PLAYER_WIN_BLACKJACK;
        break;
      case 3:
        _phase = SHOWDOWN_PHASE;
        _result = PUSH;
        break;
    }
  }

  // act when kicked by timer
  void kick() {
    if (_phase == DEALER_PHASE) {
      dealerTurn();
    }
    if (_phase == SHOWDOWN_PHASE) {
      showdown();
    }
  }

  // player draws a card
  void playerDraw() {
    playerHand.draw();
    if (playerHand.isBusted) {
      _phase = DEALER_PHASE;
      _result = DEALER_WIN_BUST;
    }
  }

  // player stands, triggering dealer's turn
  void playerStand() {
    _phase = DEALER_PHASE;
  }

  // dealer either draws or stands
  void dealerTurn() {
    int dVal = dealerHand.value;
    int pVal = playerHand.value;
    bool stand = false;
    if ((dVal >= HARD_STAND && dealerHand.isHard) ||
        (dVal >= SOFT_STAND && dealerHand.isSoft)) stand = true;
    if (!stand) dealerHand.draw();
    if (dealerHand.isBusted || stand) _phase = SHOWDOWN_PHASE;
    if (dealerHand.isBusted) _result = PLAYER_WIN_BUST;
  }

  // determine game results, if necessary
  void showdown() {
    if (_result == -1) {
      if (playerHand.value > dealerHand.value) _result = PLAYER_WIN;
      if (playerHand.value < dealerHand.value) _result = DEALER_WIN;
      if (playerHand.value == dealerHand.value) _result = PUSH;
    }
  }

  // only valid during showdown phase
  String getResults() {
    String res = "Unknown result";
    switch (_result) {
      case DEALER_WIN_BLACKJACK:
        res = "Dealer has blackjack; you lose.";
        break;
      case PLAYER_WIN_BLACKJACK:
        res = "You have a blackjack; you win!";
        break;
      case DEALER_WIN:
        res =
            "You have ${playerHand.value}; dealer has ${dealerHand.value}. Dealer wins.";
        break;
      case PLAYER_WIN:
        res =
            "You have ${playerHand.value}; dealer has ${dealerHand.value}. You win!";
        break;
      case PUSH_BLACKJACK:
        res = "You and the dealer both have blackjack; it's a push.";
        break;
      case PUSH:
        res = "You and the dealer both have ${playerHand.value}; it's a push.";
        break;
      case DEALER_WIN_BUST:
        res = "Dealer busted; you win!";
        break;
      case PLAYER_WIN_BUST:
        res = "You busted; dealer wins.";
        break;
    }
    return res;
  }
}
