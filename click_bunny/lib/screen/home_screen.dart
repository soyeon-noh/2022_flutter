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

  void _tapSoundPlay() {
    _player?.dispose();
    final player = _player = AudioPlayer();
    player.play(AssetSource('sound/Blop.mp3'));
  }

  void _onTapUp() {
    setState(() {
      touch = true;
    });
    print("_onTapUp");
  }

  void _onTapCancel() {
    setState(() {
      touch = true;
      print("_onTapCancel");
    });
  }

  Future<void> _onTapDown() async {
    _tapSoundPlay();

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
        child: InkWell(
          onTapUp: (TapUpDetails) {
            _onTapUp();
          },
          onTapDown: (TapDownDetails) {
            _onTapDown();
          },
          onTapCancel: () {
            _onTapCancel();
          },
          child: GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _TopPart(counter: counter),
                  _BottomPart(counter: counter),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  final int counter;

  const _BottomPart({
    required this.counter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? version;

    version = counter / 100;

    if (counter > 1000) {
      version = version % 10;
    }

    print(version);

    return Expanded(
      flex: 4,
      child: Image.asset('assets/img/${version.toInt()}.png'),
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
            '$counter',
            style: TextStyle(
              fontFamily: 'Jua',
              fontSize: 30.0,
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }
}
