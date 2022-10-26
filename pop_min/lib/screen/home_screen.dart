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
  String? gesture;

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

  void _onTapCancel(){
    setState(() {
      touch = true;
      print("_onTapCancel");

      gesture = 'smile';
    });

    print('제스쳐$gesture');
  }


  void _onLongPress(){
    setState((){
      // touch = false;
      print("_onDoubleTap");

      gesture = 'sad';
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

      // gesture 초기화 - 하지 않으면 계속 웃는 얼굴임
      gesture = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
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
                  _BottomPart(touch: touch, counter: counter, gesture: gesture),
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
  final bool touch;
  final int counter;
  final String? gesture;

  const _BottomPart({
    required this.touch,
    required this.counter,
    required this.gesture,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? name;
    String? version;

    print(gesture);
    if (gesture != null) {
      version = gesture;
    } else if (gesture == null) {
      version = '01';

      if (counter % 10 == 0) {
        version = '03';
      }

      if (counter % 100 == 0) {
        version = '02';
      }
    }

    if (touch) {
      name = 'close';
    } else {
      name = 'open';
    }

    return Expanded(
      flex: 4,
      child: Image.asset('assets/img/$version$name.png'),
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
            '최민환',
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
