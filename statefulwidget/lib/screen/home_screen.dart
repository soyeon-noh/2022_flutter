import 'package:flutter/material.dart';

/**
 * statefulWidget의 생명주기
 */
class HomeScreen extends StatefulWidget {
  final Color color;

  HomeScreen({
    required this.color,
    Key? key,
  }) : super(key: key) {
    print('Widget Constructor 실행!');
  }

  @override
  State<StatefulWidget> createState() {
    print("createState 실행!");
    return _HomeScreenState();
  }
}

// state는 재사용하는데 constructure는 한번만 불리기때문에 생성자로 color를 지정하면 안된다.
// wiget이라는 키워드를 사용하여 statefulWidget의 요소를 가져올 수 있다.
class _HomeScreenState extends State<HomeScreen> {
  int number = 0;

  @override
  void initState() {
    print('initState 실행!');
    super.initState(); // state 클래스에서 state를 만들때 작업들을 해준다.
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies 실행!');
    super.didChangeDependencies();
  }

  // dirty 상태로 돌아감

  @override
  Widget build(BuildContext context) {
    print('build 실행!');
    return GestureDetector(
      onTap: (){
        setState((){
          number ++;
        });
      },
      child: Container(
        width: 50.0,
        height: 50.0,
        color: widget.color,
        child: Center(
          child: Text(number.toString()),
        ),
      ),
    );
  }

  // clean 상태로 돌아감

  // 삭제할 때
  @override
  void deactivate() {
    print('deactivate 실행!');
    super.deactivate();
  }

  @override
  void dispose() {
    print('dispose 실행!');
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    print('didUpdateWidget 실행!');
    super.didUpdateWidget(oldWidget);
  }
}
