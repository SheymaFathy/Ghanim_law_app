import 'package:equatable/equatable.dart';

class Links extends Equatable {
  final String? first;
  final dynamic last;
  final dynamic prev;
  final dynamic next;

  const Links({this.first, this.last, this.prev, this.next});

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json['first'] as String?,
        last: json['last'] as dynamic,
        prev: json['prev'] as dynamic,
        next: json['next'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'first': first,
        'last': last,
        'prev': prev,
        'next': next,
      };

  @override
  List<Object?> get props => [first, last, prev, next];
}
