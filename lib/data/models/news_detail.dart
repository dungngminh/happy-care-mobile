class NewsDetail {
  String? title;
  String? description;
  String? imgUrl;
  String? link;

  NewsDetail({this.title, this.description, this.imgUrl, this.link});

  @override
  String toString() {
    return 'NewsDetail(title: $title, description: $description, imgUrl: $imgUrl, link: $link)';
  }

  factory NewsDetail.fromJson(Map<String, dynamic> json) => NewsDetail(
        title: json['title'] as String?,
        description: json['description'] as String?,
        imgUrl: json['imgUrl'] as String?,
        link: json['link'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'imgUrl': imgUrl,
        'link': link,
      };
}
