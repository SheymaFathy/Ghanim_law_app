import 'package:file_downloader_flutter/file_downloader_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/auto_direction.dart';
import 'package:ghanim_law_app/core/constants/styles.dart';

import '../../view_model/cubit/my_order_details_cubit.dart';
import 'my_order_details_transaction_details_widget.dart';
import 'my_order_preson_details_widget.dart';

class MyOrderDetailsViewBody extends StatelessWidget {
  const MyOrderDetailsViewBody({super.key, required this.state});
  final MyOrderDetailsState state;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyOrderPersonDetailsWidget(state: state),
                MyOrdersDetailsTransactionDetailsWidget(state: state)
              ],
            ),
          ),
          if (state.myOrderDetailsModel!.data!.status!.code == 'completed')
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: Text(
                      "${"file".tr(context)}${state.myOrderDetailsModel!.data!.type!.label!}"),
                  children: [
                    InkWell(
                        borderRadius: BorderRadius.circular(7.0),
                        onTap: () async {
                          await FileDownloaderFlutter().urlFileSaver(
                              url: state.myOrderDetailsModel!.data!.pdf!);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 6),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(7.0)),
                              child: Row(
                                children: [
                                  Text(
                                    "Download pdf".tr(context),
                                    style: Styles.textStyle16,
                                  ),
                                  Spacer(),
                                  Icon(Icons.download)
                                ],
                              )),
                        ))
                  ],
                ),
              ),
            ),
          if (state.myOrderDetailsModel!.data!.status!.code == 'rejected')
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                    title: Text("Reject Reason".tr(context)),
                    children: [
                      Container(
                        width: double.infinity,
                        child: AutoDirection(
                          text: state.myOrderDetailsModel!.data!.rejectReason,
                          child: Text(
                            state.myOrderDetailsModel!.data!.rejectReason,
                            style: Styles.textStyle16,
                          ),
                        ),
                      ),
                    ]),
              ),
            )
        ],
      ),
    );
  }
}
