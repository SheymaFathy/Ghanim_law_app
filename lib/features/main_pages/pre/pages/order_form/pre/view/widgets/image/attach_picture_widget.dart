import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/order_form/pre/view_model/cubit/add_order_cubit.dart';

attachPictureWidget(BuildContext orderCtx) {
  return showDialog(
    context: orderCtx,
    builder: (BuildContext context) {
      return BlocProvider.value(
        value: AddOrderCubit(),
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
  );
}

attachVoiceWidget(BuildContext orderCtx) {
  return showDialog(
    useRootNavigator: false,
    barrierDismissible: false,
    context: orderCtx,
    builder: (BuildContext context) {
      return BlocProvider.value(
        value: AddOrderCubit(),
        child: BlocBuilder<AddOrderCubit, AddOrderState>(
          builder: (context, state) {
            return AlertDialog(
                title: const Text('voice'),
                content: Row(
                  children: [
                    IconButton(
                        onPressed: state.isRecording
                            ? context.read<AddOrderCubit>().stopRecording
                            : context.read<AddOrderCubit>().startRecording,
                        icon: Icon(
                            color: state.isRecording ? Colors.red : Colors.blue,
                            state.isRecording ? Icons.mic_off : Icons.mic)),
                    Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AddOrderCubit>(orderCtx)
                              .saveRecordInList(context
                                  .read<AddOrderCubit>()
                                  .fileRecordPath!);
                        },
                        child: Text("save"))
                  ],
                ));
          },
        ),
      );
    },
  );
}
