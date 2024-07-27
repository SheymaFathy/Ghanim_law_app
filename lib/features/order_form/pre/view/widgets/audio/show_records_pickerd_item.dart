import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import '../../../../../record_player/view/widget/show_audio_player_dialog.dart';
import '../../../view_model/cubit/add_order_cubit.dart';
import 'delete_audio_dialog.dart';

class ShowRecordsPickerdItem extends StatelessWidget {
  const ShowRecordsPickerdItem(
      {super.key, required this.addOrderCubit, required this.state});

  final AddOrderCubit addOrderCubit;
  final AddOrderState state;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 10),
                    Text(
                        "${"record_voice".tr(context)} ( ${(index).toString()} )"),
                    const Spacer(),
                    if (!state.isRecording)
                      IconButton(
                        icon: const Icon(Icons.play_arrow),
                        onPressed: () {
                          showAudioPlayerDialog(context, state.records!.path);
                        },
                      ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDeleteAudioDialog(index, "audio", context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
