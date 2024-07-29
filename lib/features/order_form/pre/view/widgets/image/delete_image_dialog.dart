import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import '../../../../../../core/get_it/service_locator.dart';
import '../../../view_model/cubit/add_order_cubit.dart';

void showDeletePhotoDialog(
    int index, String fileType, BuildContext oldContext) {
  showDialog(
    context: oldContext,
    builder: (BuildContext context) {
      return BlocProvider.value(
        value: getIt<AddOrderCubit>(),
        child: BlocBuilder<AddOrderCubit, AddOrderState>(
          builder: (context, state) {
            return AlertDialog(
              title: Text('delete_pic_title'.tr(context)),
              content: Text('delete_pic_content'.tr(context)),
              actions: <Widget>[
                TextButton(
                  child: Text('cancel'.tr(context)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('delete'.tr(context)),
                  onPressed: () {
                    BlocProvider.of<AddOrderCubit>(context)
                        .deleteFiles(index, fileType);
                    Navigator.of(context).pop();
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
