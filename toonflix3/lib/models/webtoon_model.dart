class WebtoonModel {
  final String title, thumb, id;

// namedStructure
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
