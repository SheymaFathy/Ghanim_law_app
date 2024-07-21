import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/get_it/service_locator.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/order_form/pre/view_model/cubit/add_order_cubit.dart';

void showFileOptionsDialog(int index, String fileType, BuildContext orderCtx) {
  showDialog(
    context: orderCtx,
    builder: (BuildContext orderCtx) {
      return BlocProvider.value(
        value: getIt<AddOrderCubit>(),
        child: BlocBuilder<AddOrderCubit, AddOrderState>(
          builder: (context, state) {
            return AlertDialog(
              title: Text(
                  'خيارات ${fileType == "image" ? 'الصورة' : (fileType == "audio" ? 'الصوت' : 'الملف')}'),
              content: Text(
                  'هل تريد حذف هذا ${fileType == "image" ? 'الصورة' : (fileType == "audio" ? 'الصوت' : 'الملف')}؟'),
              actions: <Widget>[
                TextButton(
                  child: const Text('إلغاء'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('حذف'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    BlocProvider.of<AddOrderCubit>(context)
                        .deleteFiles(index, fileType);
                  },
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
