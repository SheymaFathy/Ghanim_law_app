import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import 'package:image_picker/image_picker.dart';

class AddOrderModel extends Equatable {
  final String? name;
  final String? email;
  final String? phone;
  final String? description;
  final String? typeOrder;
  final XFile? voice;
  final List<XFile>? image;
  final List<PlatformFile>? docs;

  const AddOrderModel({
    this.name,
    this.email,
    this.phone,
    this.typeOrder,
    this.voice,
    this.image,
    this.docs,
    this.description,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        typeOrder,
        voice,
        image,
        docs,
        description,
      ];
}
