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
  String name = '레나드를 눌러주세요!';
  Color nameColor = const Color(0xffA3815A);
  Color backgroundColor = const Color(0xffFFDFDF);
  BoxDecoration? gradientBoxDecoration;
  // BoxDecoration(
  //     gradient: LinearGradient(
  //   colors: [
  //     Color(0xffEBDDCC),
  //     Color(0xffD0AB8F),
  //   ],
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomRight,
  // ));

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

      gesture = 'smile';
    });

    // print('제스쳐$gesture');
  }

  void _onLongPress() {
    setState(() {
      touch = true;
      print("_onLongPress");

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
      backgroundColor: backgroundColor,
      body: Container(
        decoration: gradientBoxDecoration,
        child: SafeArea(
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
            // onLongPress: () {
            //   _onLongPress();
            // },

            child: GestureDetector(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _TopPart(
                      counter: counter,
                      name: name,
                      nameColor: nameColor,
                    ),
                    _BottomPart(
                        touch: touch, counter: counter, gesture: gesture),
                  ],
                ),
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

    if (gesture != null) {
      version = gesture;
    } else if (gesture == null) {
      version = '01';

      if (counter % 10 == 0) {
        version = '02';
      }

      if (counter % 100 == 0) {
        version = '03';
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
  final String name;
  final Color nameColor;

  const _TopPart({
    required this.counter,
    required this.name,
    required this.nameColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(
              fontFamily: 'Jua',
              fontSize: 30.0,
              color: nameColor,
            ),
          ),
          Text(
            '$counter',
            style: TextStyle(
              fontFamily: 'Jua',
              fontSize: 18.0,
              color: nameColor,
            ),
          )
        ],
      ),
    );
  }
}
