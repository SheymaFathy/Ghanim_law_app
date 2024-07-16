import 'package:equatable/equatable.dart';

class ErorrMessageModel extends Equatable {
  final String statusMessage;

  const ErorrMessageModel({
    required this.statusMessage,
  });
  factory ErorrMessageModel.fromJson(String json) {
    return ErorrMessageModel(
      statusMessage: json,
    );
  }
  @override
  List<Object?> get props => [
        statusMessage,
      ];
}
