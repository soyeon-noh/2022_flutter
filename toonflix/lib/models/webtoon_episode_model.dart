class WebtoonEpisodeMpdel {
  final String id, title, rating, date;

  WebtoonEpisodeMpdel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json["title"],
        rating = json['rating'],
        date = json['date'];
}
