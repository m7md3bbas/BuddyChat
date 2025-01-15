import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_cubit.dart';
import 'package:TaklyAPP/features/home/presentation/manager/cubit/home_state.dart';
import 'package:TaklyAPP/features/home/presentation/views/add_contact.dart';
import 'package:TaklyAPP/features/home/presentation/views/drawer.dart';
import 'package:TaklyAPP/features/home/presentation/views/widgets/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context).getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Theme.of(context).colorScheme.primary,
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BuildDrawer())),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Obx(() {
          return Text(
            'chats'.tr,
            style: TextStyle(
              fontSize: Get.find<FontSizeController>().fontSize.value,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          );
        }),
        centerTitle: true,
      ),
      drawer: const BuildDrawer(),
      drawerEnableOpenDragGesture: false,
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<HomeCubit>(context).getUsers();
        },
        child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
          return state.contacts == null
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: state.contacts!.length,
                  itemBuilder: (context, index) {
                    final contact = state.contacts![index];
                    return buildContactCard(
                      context,
                      contact,
                    );
                  },
                );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shape: const CircleBorder(),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddContact()));
        },
      ),
    );
  }
}
