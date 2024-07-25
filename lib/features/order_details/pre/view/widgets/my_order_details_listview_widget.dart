import 'package:flutter/material.dart';

import '../../view_model/cubit/my_order_details_cubit.dart';
import 'build_listview_files_item.dart';

class MyOrderDetailsListViewWidget extends StatelessWidget {
  const MyOrderDetailsListViewWidget({
    super.key,
    required this.state,
  });

  final MyOrderDetailsState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: state.myOrderDetailsModel!.data!.documents!.length,
      itemBuilder: (ctx, index) {
        return BuildListViewFilesItem(
          fileName: state.myOrderDetailsModel!.data!.documents![index],
          isDoc: true,
        );
      },
    );
  }
}
