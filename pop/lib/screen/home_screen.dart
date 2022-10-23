import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int counter = 0;
  bool touch = false;

  AudioPlayer? _player;

  @override
  void dispose() {
    _player?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = (prefs.getInt('counter') ?? 0);
    });
  }

  void _onTapUp() {
    setState(() {
      // counter++;
      touch = true;
      print("_onTapUp");
    });
  }

  Future<void> _onTapDown() async {
    _player?.dispose();
    final player = _player = AudioPlayer();
    player.play(AssetSource('sound/Blop.mp3'));

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', counter);
      touch = false;
      print("_onTapDown");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SafeArea(
        child: GestureDetector(
          onTapUp: (TapUpDetails) {
            _onTapUp();
          },
          onTapDown: (TapDownDetails) {
            _onTapDown();
          },
          onTapCancel: () {
            _onTapUp();
            print("onTapcancel");
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _TopPart(counter: counter),
                _BottomPart(touch: touch),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  final bool touch;

  const _BottomPart({
    required this.touch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name;
    if (touch) {
      name = 'close';
    } else {
      name = 'open';
    }

    return Expanded(
      flex: 4,
      child: Image.asset('assets/img/$name.png'),
    );
  }
}

class _TopPart extends StatelessWidget {
  final int counter;

  _TopPart({required this.counter, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '꿀호떡',
            style: TextStyle(
              fontFamily: 'Jua',
              fontSize: 30.0,
              color: Colors.black54,
            ),
          ),
          Text(
            '$counter',
            style: TextStyle(
              fontFamily: 'Jua',
              fontSize: 18.0,
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }
}
