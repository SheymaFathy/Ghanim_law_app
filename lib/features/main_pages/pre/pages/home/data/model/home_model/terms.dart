import 'package:equatable/equatable.dart';

class Terms extends Equatable {
  final String? link;
  final String? content;

  const Terms({this.link, this.content});

  factory Terms.fromJson(Map<String, dynamic> json) => Terms(
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
