import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/styles.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';

class MyOrderDetails extends StatelessWidget {
  const MyOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "order_details".tr(context)),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[200]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "legal_advice".tr(context),
              style: Styles.textStyle18,
            ),
            const SizedBox(
              height: 10,
            ),
            const ListTile(
              leading: Text("الحالة : ", style: Styles.textStyle14),
              trailing: Text(
                "تحت الدراسة",
                style: Styles.textStyle14,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const ListTile(
              leading: Text("الاسم :  ", style: Styles.textStyle14),
              trailing: Text(
                "احمد فتحي زكي",
                style: Styles.textStyle14,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const ListTile(
              leading:
                  Text("البريد الاليكتروني :  ", style: Styles.textStyle14),
              trailing: Text(
                "email@gmail.com",
                style: Styles.textStyle14,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              textAlign: TextAlign.start,
              "تفاصيل الاستشارة",
              style: Styles.textStyle16,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
                " تفاصيل الاستشارة تفاصيل الاستشارة تفاصيل الاستشارة تفاصيل الاستشارة تفاصيل الاستشارة تفاصيل الاستشارة تفاصيل الاستشارة تفاصيل الاستشارة"),
          ],
        ),
      ),
    );
  }
}
