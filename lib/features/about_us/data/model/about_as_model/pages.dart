import 'package:equatable/equatable.dart';

import 'about.dart';
import 'privacy.dart';
import 'terms.dart';

class Pages extends Equatable {
  final About? about;
  final Terms? terms;
  final Privacy? privacy;

  const Pages({this.about, this.terms, this.privacy});

  factory Pages.fromJson(Map<String, dynamic> json) => Pages(
        about: json['about'] == null
            ? null
            : About.fromJson(json['about'] as Map<String, dynamic>),
        terms: json['terms'] == null
            ? null
            : Terms.fromJson(json['terms'] as Map<String, dynamic>),
        privacy: json['privacy'] == null
            ? null
            : Privacy.fromJson(json['privacy'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'about': about?.toJson(),
        'terms': terms?.toJson(),
        'privacy': privacy?.toJson(),
      };

  @override
  List<Object?> get props => [about, terms, privacy];
}
