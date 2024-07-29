import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ghanim_law_app/features/order_form/pre/view_model/cubit/add_order_cubit.dart';

import '../../../../../../core/get_it/service_locator.dart';

attachPictureWidget(BuildContext orderCtx) {
  return showDialog(
    context: orderCtx,
    builder: (BuildContext context) {
      return BlocProvider.value(
        value: getIt<AddOrderCubit>(),
        child: BlocBuilder<AddOrderCubit, AddOrderState>(
          builder: (context, state) {
            return AlertDialog(
              title: const Text('اختر مصدر الصورة'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('معرض الصور'),
                      onTap: () {
                        Navigator.of(context).pop();
                        BlocProvider.of<AddOrderCubit>(orderCtx)
                            .pickImagesFromGallery();
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.camera_alt),
                      title: const Text('كاميرا'),
                      onTap: () {
                        Navigator.of(context).pop();
                        BlocProvider.of<AddOrderCubit>(orderCtx)
                            .takePictureWithCamera();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  ).then((onValue) {});
}