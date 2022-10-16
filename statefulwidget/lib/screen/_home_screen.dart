import 'package:flutter/material.dart';

/**
 * statefulWidget 과 statelessWidget 의 차이
 */
// statefulWidget
class HomeScreen extends StatefulWidget {
  final Color color;

  const HomeScreen({
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }

  // create State

}

// state는 재사용하는데 constructure는 한번만 불리기때문에 생성자로 color를 지정하면 안된다.
// wiget이라는 키워드를 사용하여 statefulWidget의 요소를 가져올 수 있다.
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      color: widget.color,
    );
  }
}

// statelessWidget
// 생성자에 color를 지정하여 사용
class _HomeScreen extends StatelessWidget {
  final Color color;

  const _HomeScreen({
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      color: color,
    );
  }
}
