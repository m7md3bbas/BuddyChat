import 'package:TaklyAPP/core/widgets/snack_bar.dart';
import 'package:TaklyAPP/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:TaklyAPP/features/auth/presentation/views/login.dart';
import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_state.dart';
import 'package:TaklyAPP/features/settings/presentation/views/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildDrawer extends StatefulWidget {
  const BuildDrawer({
    super.key,
  });

  @override
  State<BuildDrawer> createState() => _BuildDrawerState();
}

class _BuildDrawerState extends State<BuildDrawer> {
  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context).currentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .30,
            child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                ),
                currentAccountPicture: BlocConsumer<HomeCubit, HomeState>(
                  listener: (context, state) {
                    if (state.status == HomeStatus.error) {
                      GetSnacbars.errorSnackbar(state.failure?.message ?? "");
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        context.read<HomeCubit>().pickImage();
                      },
                      child: CircleAvatar(
                          backgroundColor: Colors.transparent.withOpacity(0.1),
                          child: Image.asset(
                            "assets/images/default_avatar_dark.png",
                            scale: 8,
                          )),
                    );
                  },
                ),
                accountName: BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.user != current.user,
                  builder: (context, state) => Text(
                    state.user?.name ?? "",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                accountEmail: BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.user != current.user,
                  builder: (context, state) {
                    return Text(
                      state.user?.email ?? "",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
                currentAccountPictureSize: const Size(
                  110,
                  110,
                )),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(
              "home",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(
              "settings",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Setting()));
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(
              "logout",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () async {
              context.read<AuthCubit>().logoutUser();
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              });
            },
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
