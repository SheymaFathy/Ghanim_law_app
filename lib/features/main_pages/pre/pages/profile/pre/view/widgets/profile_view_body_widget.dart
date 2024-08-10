import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      padding: const EdgeInsets.all(5.0),
      child: Column(children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.surface,
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

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            leading: const Icon(Icons.email),
            title: Text(
              prfileData.email!,
            ),
          ),
        ),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            leading: const Icon(Icons.phone),
            title: Text(
              prfileData.phone!,
            ),
          ),
        ),
        //
      ]),
    );
  }
}
