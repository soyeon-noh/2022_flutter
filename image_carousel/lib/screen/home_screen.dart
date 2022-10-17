import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  PageController controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      int currentPage = controller.page!.toInt();
      int nextPage = currentPage + 1;

      if (nextPage > 4) {
        nextPage = 0;
      }

      controller.animateToPage(nextPage,
          duration: Duration(milliseconds: 400), curve: Curves.linear);
    });
  }

  // homeScreen이 삭제될 때 Timer도 멈추게하는 것
  @override
  void dispose() {
    //controller도 삭제해줘야함
    controller.dispose();
    if (timer != null) {
      // timer가 널이 아니라는 걸 알려주는 느낌표
      timer!.cancel();
    }
    // super.dispose() 위에 작성해야함. 사라져버림
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // system ui(상태바)를 검은색으로 바꿔줌
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: PageView(
        controller: controller,
        children: [1, 2, 3, 4, 5]
            .map(
              (e) => Image.asset(
                'asset/img/image_$e.jpeg',
                fit: BoxFit.cover,
              ),
            )
            .toList(),
      ),
    );
  }
}
