// ignore_for_file: file_names

class ServerException implements Exception {
  final String erorrMessageModel;
  final int statusCode;
  const ServerException(
      {required this.erorrMessageModel, required this.statusCode});
}
