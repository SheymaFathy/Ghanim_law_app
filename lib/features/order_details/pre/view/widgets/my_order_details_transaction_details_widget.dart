import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/features/order_details/pre/view/widgets/my_order_description_text_widget.dart';
import '../../view_model/cubit/my_order_details_cubit.dart';
import 'build_listview_files_item.dart';
import 'my_order_details_listview_widget.dart';

class MyOrdersDetailsTransactionDetailsWidget extends StatelessWidget {
  const MyOrdersDetailsTransactionDetailsWidget({
    super.key,
    required this.state,
  });

  final MyOrderDetailsState state;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("details".tr(context).toUpperCase()),
      children: [
        if (state.myOrderDetailsModel!.data!.description != null)
          MyOrderDescriptionTextWidget(
              description: state.myOrderDetailsModel!.data!.description!),
        if (state.myOrderDetailsModel!.data!.documents != null)
          MyOrderDetailsListViewWidget(state: state),
        if (state.myOrderDetailsModel!.data!.voice != null &&
            state.myOrderDetailsModel!.data!.voice != '')
          BuildListViewFilesItem(
              fileName: state.myOrderDetailsModel!.data!.voice!, isVoice: true),
        if (state.myOrderDetailsModel!.data!.image != null)
          BuildListViewFilesItem(
              fileName: state.myOrderDetailsModel!.data!.image!, isImage: true)
      ],
    );
  }
}
