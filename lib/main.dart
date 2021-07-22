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

  _BJWidgetState() {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      game.kick();
      _updateWidget();
    });
  }

  void _updateWidget() {
    setState(() {
      _dealerString = game.dealerHand.string;
      _playerString = game.playerHand.string;
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
      Text(
        _dealerString,
      ),
    );
    buttons.add(
      Text(
        _playerString,
      ),
    );
    if (game.phase == BlackjackGame.SHOWDOWN_PHASE) {
      buttons.add(
        ElevatedButton(
          onPressed: () {
            game.newGame();
            _updateWidget();
          },
          child: Text("New Game"),
        ),
      );
    }
    if (game.phase == BlackjackGame.PLAYER_PHASE) {
      buttons.add(
        ElevatedButton(
          onPressed: () {
            game.playerDraw();
            _updateWidget();
          },
          child: Text("Hit"),
        ),
      );
      buttons.add(
        ElevatedButton(
          onPressed: () {
            game.playerStand();
            _updateWidget();
          },
          child: Text("Stand"),
        ),
      );
    }
    return buttons;
  }
}
