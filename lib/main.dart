import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(UpDownGame());

class UpDownGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '업다운 게임',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Random _random = Random();
  late int _targetNumber;
  int _hearts = 5;
  String _message = '';
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    setState(() {
      _targetNumber = _random.nextInt(100) + 1;
      _hearts = 5;
      _message = '';
    });
  }

  void _checkGuess() {
    int? guess = int.tryParse(_controller.text);
    if (guess == null) {
      setState(() {
        _message = '유효한 숫자를 입력해주세요.';
      });
      return;
    }

    setState(() {
      if (guess == _targetNumber) {
        _message = '축하합니다! 숫자를 맞추셨습니다!';
      } else {
        _hearts--;
        if (_hearts == 0) {
          _message = '게임 오버! 정답은 $_targetNumber 였습니다.';
        } else if (guess < _targetNumber) {
          _message = '업! 더 높은 숫자입니다.';
        } else {
          _message = '다운! 더 낮은 숫자입니다.';
        }
      }
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('업다운 게임')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('1부터 100 사이의 숫자를 맞춰보세요!'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Icon(
                  index < _hearts ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                  size: 30,
                );
              }),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: '숫자를 입력하세요'),
            ),
            ElevatedButton(
              child: Text('확인'),
              onPressed: _checkGuess,
            ),
            Text(_message, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('게임 초기화'),
              onPressed: _initializeGame,
            ),
          ],
        ),
      ),
    );
  }
}