import 'package:equatable/equatable.dart';

class Privacy extends Equatable {
  final String? link;
  final String? content;

  const Privacy({this.link, this.content});

  factory Privacy.fromJson(Map<String, dynamic> json) => Privacy(
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
