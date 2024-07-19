import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../core/constants/app_colors.dart';
import '../../../../../../../../core/constants/app_router.dart';
import '../../../../../../../../core/constants/styles.dart';
import '../../view_model/cubit/profile_cubit.dart';

class ProfileViewBodyWidget extends StatelessWidget {
  const ProfileViewBodyWidget({super.key, required this.state});
  final ProfileState state;
  @override
  Widget build(BuildContext context) {
    final prfileData = state.profileModel!.data;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(children: [
        CircleAvatar(
          backgroundColor: AppColors.backgroundColor,
          radius: 60,
          backgroundImage: NetworkImage(state.profileModel!.data!.avatar!),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(prfileData!.name!, style: Styles.textStyle18),
            IconButton(
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.kUpdateProfile);
                },
                icon: const Icon(Icons.edit))
          ],
        ),

        Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          color: Colors.white,
          child: ListTile(
            leading: Icon(Icons.email, color: Colors.blueGrey[900]),
            title: Text(
              prfileData.email!,
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
              prfileData.phone!,
              style: TextStyle(color: Colors.blueGrey[900]),
            ),
          ),
        ),
        //
      ]),
    );
  }
}
