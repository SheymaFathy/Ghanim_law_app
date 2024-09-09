import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/get_it/service_locator.dart';
import 'package:ghanim_law_app/features/order_form/pre/view_model/cubit/add_order_cubit.dart';

void showDeleteFileDialog(int index, String fileType, BuildContext orderCtx) {
  showDialog(
    context: orderCtx,
    builder: (BuildContext context) {
      return BlocProvider.value(
        value: getIt<AddOrderCubit>(),
        child: BlocBuilder<AddOrderCubit, AddOrderState>(
          builder: (context, state) {
            return AlertDialog(
              title: Text('delete_file_title'.tr(context)),
              content: Text('delete_file_content'.tr(context)),
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
                    Navigator.of(context).pop();
                    BlocProvider.of<AddOrderCubit>(orderCtx)
                        .deleteFile(index, fileType);
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
