// ignore_for_file: file_names

import 'package:ghanim_law_app/core/erorr/erorrMessageModel.dart';

class ServerException implements Exception {
  final String erorrMessageModel;

  const ServerException({required this.erorrMessageModel});
}
