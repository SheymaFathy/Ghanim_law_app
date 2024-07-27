import 'package:equatable/equatable.dart';

class About extends Equatable {
  final String? link;
  final String? content;

  const About({this.link, this.content});

  factory About.fromJson(Map<String, dynamic> json) => About(
        link: json['link'] as String?,
        content: json['content'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'link': link,
        'content': content,
      };

  @override
  List<Object?> get props => [link, content];
}
