import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/pre/view/widgets/service_widget.dart';



class HomePage extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    final List<Service> services = [
      Service(name: 'legal-consultations'.tr(context), icon: Icons.gavel, price: 100.0, ),
      Service(name: 'preparing-and-reviewing-contract'.tr(context), icon: Icons.description, price: 200.0,  ),
      Service(name: 'preparing-and-reviewing-book'.tr(context), icon: Icons.book, price: 300.0,),
    ];
    return Scaffold(
      appBar: myAppBar(context, "our_services".tr(context)),
      body: Center(
        child: Expanded(
          child: ListView.builder(
            itemCount: services.length,
            itemBuilder: (context, index) {
              return ServiceWidget(service: services[index]);
            },
          ),
        ),
      ),
    );
  }
}
