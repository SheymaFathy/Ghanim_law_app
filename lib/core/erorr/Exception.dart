// ignore_for_file: file_names

class ServerException implements Exception {
  final String erorrMessageModel;

  const ServerException({required this.erorrMessageModel});
}
