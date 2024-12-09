
import 'package:TaklyAPP/core/widgets/custom_fading.dart';
import 'package:flutter/material.dart';

class HeaderFadingDrawer extends StatelessWidget {
  const HeaderFadingDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomFadingWidget(
        child: SizedBox(
      height: MediaQuery.of(context).size.height * .30,
      child: UserAccountsDrawerHeader(
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
        ),
        accountName: Container(
          color: Colors.grey,
          height: 15,
          width: 80,
        ),
        accountEmail: Container(
          color: Colors.grey,
          height: 15,
          width: 150,
        ),
        currentAccountPictureSize: const Size(130, 130),
        currentAccountPicture: const CircleAvatar(
          backgroundColor: Colors.grey,
        ),
      ),
    ));
  }
}
