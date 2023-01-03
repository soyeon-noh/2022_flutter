import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        elevation: 2,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          // future가 데이터를 받았는지 오류가 났는지 snapshot으로 확인가능 (Future의 상ㅌ)
          if (snapshot.hasData) {
            // 최적화된 ListView (ListView.builder, ListView.separated)
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                // ListView는 무한한 높이를 가지기때문에 Expanded 등으로 감싸 높이를 지정해줘야함.
                Expanded(child: makeList(snapshot)),
              ],
            );
          }
          // 로딩중일 때
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      // 그림자가 잘려서 padding을 추가
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      // ListView builder 가 각 item을 그릴때 실행하는 것
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];

        // 그때그때마다 필요한 요소를 그려주는 것을 확인 할 수 있음
        print(index);
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      // 아이템들 사이에 구분자를 넣어주는 builder
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 40,
        );
      },
    );
  }
}
