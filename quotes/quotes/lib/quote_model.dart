class Quote {
  Quote({required this.author, required this.title});

  Quote.fromJson(Map<String, dynamic> json) {
    author = json['author'] as String;
    title = json['title'] as String;
  }

  String author = '';
  String title = '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author;
    data['title'] = title;
    return data;
  }
}
