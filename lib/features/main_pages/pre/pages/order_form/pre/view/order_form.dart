import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/app_colors.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/core/widget/custom_button.dart';
import 'package:ghanim_law_app/core/widget/global_textfield.dart';
import 'package:ghanim_law_app/features/auth/widget/custom_auth_title.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/order_form/pre/view/widgets/custom_attached_row.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({super.key});

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFiles;

  void _attachFile(BuildContext context) {}

  void _recordVoice(BuildContext context) {}

  Future<void> _pickImagesFromGallery() async {
    try {
      final List<XFile>? selectedImages = await _picker.pickMultiImage();
      if (selectedImages != null) {
        setState(() {
          _imageFiles = selectedImages;
        });
      }
    } catch (e) {
      print("Error picking images: $e");
    }
  }

  Future<void> _takePictureWithCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          _imageFiles = (_imageFiles ?? [])..add(image);
        });
      }
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  void _attachPicture(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('اختر مصدر الصورة'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('معرض الصور'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImagesFromGallery();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('كاميرا'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _takePictureWithCamera();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showImageOptions(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('خيارات الصورة'),
          content: Text('هل تريد حذف هذه الصورة؟'),
          actions: <Widget>[
            TextButton(
              child: Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('حذف'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _imageFiles!.removeAt(index);
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'submit-consultation'.tr(context)),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            const CustomTextTitleAuth(
              title: 'اخبرنا كيف نساعدك؟',
            ),
            const SizedBox(
              height: 20,
            ),
            GlobalTextfield(
              maxline: 10,
              hinttext: "submit-consultation".tr(context),
            ),
            CustomAttachedFile(
              text: 'send_file'.tr(context),
              iconData: Icons.file_present_sharp,
              ontab: () => _attachFile(context),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomAttachedFile(
              text: 'Send_voice'.tr(context),
              iconData: Icons.mic,
              ontab: () => _recordVoice(context),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomAttachedFile(
              text: 'send_pic'.tr(context),
              iconData: Icons.photo_camera_back,
              ontab: () => _attachPicture(context),
            ),
            if (_imageFiles != null && _imageFiles!.isNotEmpty)
              ..._imageFiles!.asMap().entries.map((entry) {
                int index = entry.key;
                XFile image = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.file(
                          File(image.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(image.name),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showImageOptions(index),
                      ),
                    ],
                  ),
                );
              }).toList(),
            const SizedBox(
              height: 15,
            ),
            CustomBotton(
              backgroundColor: AppColors.primeryColor,
              textColor: AppColors.backgroundColor,
              text: 'confirm'.tr(context),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
