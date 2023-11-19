typedef Parser<T> = T Function(dynamic json);

class ParserJson<T> {
  int? count;
  String? next;
  String? previous;
  late T data;

  ParserJson.fromJson(Map<String, dynamic> json, Parser<T> parser) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    data = parser(json['results']);
  }

  ParserJson(this.count, this.data, this.previous, this.next);
}
