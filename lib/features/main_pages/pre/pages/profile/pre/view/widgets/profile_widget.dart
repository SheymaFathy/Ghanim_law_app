import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/constants/app_router.dart';
import 'package:ghanim_law_app/core/constants/styles.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../../../core/constants/app_colors.dart';
import '../../../../../../../../core/constants/image_assets.dart';

class ProfileWidget extends StatelessWidget {
  final String username ;
  final String email;
  final String phone;
  const ProfileWidget({
    super.key, required this.username, required this.email, required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const CircleAvatar(
          backgroundColor: AppColors.backgroundColor,
          radius: 60,
          backgroundImage: AssetImage(AppImageAsset.profile),
        ),
        const SizedBox(height: 20),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Text(
              username,
              style: Styles.textStyle18
                     ),
             IconButton(onPressed: (){
               GoRouter.of(context).push(AppRouter.kUpdateProfile);
             }, icon: const Icon(Icons.edit))
           ],
         ),
        const SizedBox(height: 10),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          color: Colors.white,
          child: ListTile(
            leading: Icon(Icons.email, color: Colors.blueGrey[900]),
            title: Text(
              email,
              style: TextStyle(color: Colors.blueGrey[900]),
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          color: Colors.white,
          child: ListTile(
            leading: Icon(Icons.phone, color: Colors.blueGrey[900]),
            title: Text(
              phone,
              style: TextStyle(color: Colors.blueGrey[900]),
            ),
          ),
        ),
      ],
    );
  }
}