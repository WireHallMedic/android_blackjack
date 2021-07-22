import 'package:flutter/material.dart';
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<BJWidget> createState() => _BJWidgetState();
}

class _BJWidgetState extends State<BJWidget> {
  String _dealerString = "";
  String _playerString = "";
  BlackjackGame game = BlackjackGame(1, 1);

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
          children: getButtonsByPhase(game),
        ),
      ),
    );
  }

   List<Widget> getButtonsByPhase(BlackjackGame gameObj) {
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
    if (gameObj.phase == BlackjackGame.SHOWDOWN_PHASE) {
      buttons.add(
        ElevatedButton(
          onPressed: () {
            _updateWidget();
          },
          child: Text("New Game"),
        ),
      );
    } if(gameObj.phase == BlackjackGame.PLAYER_PHASE) {
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
