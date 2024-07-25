import 'package:equatable/equatable.dart';

class Meta extends Equatable {
  final int? currentPage;
  final int? from;
  final String? path;
  final int? perPage;
  final int? to;

  const Meta({
    this.currentPage,
    this.from,
    this.path,
    this.perPage,
    this.to,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json['current_page'] as int?,
        from: json['from'] as int?,
        path: json['path'] as String?,
        perPage: json['per_page'] as int?,
        to: json['to'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'from': from,
        'path': path,
        'per_page': perPage,
        'to': to,
      };

  @override
  List<Object?> get props => [currentPage, from, path, perPage, to];
}
