import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/constants/app_colors.dart';
import 'package:ghanim_law_app/core/constants/styles.dart';

class Service {
  final String name;
  final IconData icon;
  final double price;


  Service({required this.name, required this.icon, required this.price, });
}

class ServiceWidget extends StatelessWidget {
  final Service service;

  const ServiceWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      color: AppColors.backgroundColor,
      child: InkWell(
        onTap: (){
        //    Go to order form or service details
        },
        child: ListTile(
          leading: Icon(service.icon, size: 30.0),
          title: Text(
            service.name,
            style: Styles.textStyle14.copyWith(color: AppColors.primeryColor),
          ),
          trailing: Text(
            '\$${service.price.toStringAsFixed(2)}',
            style: Styles.textStyle14.copyWith(color: AppColors.green),
          ),
        ),
      ),
    );
  }
}
