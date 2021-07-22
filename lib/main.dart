import 'package:flutter/material.dart';
import 'dart:async';
import 'src/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blackjack',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const BJWidget(title: 'Blackjack'),
    );
  }
}

class BJWidget extends StatefulWidget {
  const BJWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<BJWidget> createState() => _BJWidgetState();
}

class _BJWidgetState extends State<BJWidget> {
  String _dealerString = "";
  String _playerString = "";
  BlackjackGame game = BlackjackGame(1, 1);
  static const double standardPadding = 5.0;

  _BJWidgetState() {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      game.kick();
      _updateWidget();
    });
  }

  void _updateWidget() {
    setState(() {
      if (game.phase == BlackjackGame.PLAYER_PHASE) {
        _dealerString = game.dealerHand.faceDownString;
      } else {
        _dealerString = game.dealerHand.string;
      }
      _playerString = game.playerHand.string;
      _dealerString = "Dealer has: $_dealerString";
      _playerString = "You have: $_playerString";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: getButtonsByPhase(),
        ),
      ),
    );
  }

  List<Widget> getButtonsByPhase() {
    List<Widget> buttons = [];
    buttons.add(
      Padding(
        padding: const EdgeInsets.all(standardPadding),
        child: Text(
          _dealerString,
        ),
      ),
    );
    buttons.add(
      Padding(
        padding: const EdgeInsets.all(standardPadding),
        child: Text(
          _playerString,
        ),
      ),
    );
    if (game.phase == BlackjackGame.SHOWDOWN_PHASE) {
      buttons.add(
        Padding(
          padding: const EdgeInsets.all(standardPadding),
          child: Text(
            game.getResults(),
          ),
        ),
      );
      buttons.add(
        Padding(
          padding: const EdgeInsets.all(standardPadding),
          child: ElevatedButton(
            onPressed: () {
              game.newGame();
              _updateWidget();
            },
            child: Text("New Game"),
          ),
        ),
      );
    }
    if (game.phase == BlackjackGame.PLAYER_PHASE) {
      buttons.add(
        Padding(
          padding: const EdgeInsets.all(standardPadding),
          child: ElevatedButton(
            onPressed: () {
              game.playerDraw();
              _updateWidget();
            },
            child: Text("Hit"),
          ),
        ),
      );
      buttons.add(
        Padding(
          padding: const EdgeInsets.all(standardPadding),
          child: ElevatedButton(
            onPressed: () {
              game.playerStand();
              _updateWidget();
            },
            child: Text("Stand"),
          ),
        ),
      );
    }
    return buttons;
  }
}
