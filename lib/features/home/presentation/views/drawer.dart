import 'package:TaklyAPP/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:TaklyAPP/features/auth/presentation/views/login.dart';
import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({
    super.key,
  });

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
                accountName: BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.user != current.user,
                  builder: (context, state) => Text(
                    state.user?.name ?? "null",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                accountEmail: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return Text(
                      state.user!.email,
                      style: TextStyle(
                        
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
                currentAccountPictureSize: const Size(130, 130)),
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
            onTap: () {},
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
            onTap: () {},
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
