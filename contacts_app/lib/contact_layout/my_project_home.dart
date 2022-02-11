import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:contacts_app/contact_layout/cubit/cubit.dart';
import 'package:contacts_app/contact_layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProjectHome extends StatelessWidget {
  MyProjectHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ContactCubit()..createContactDatabase(),
      child: BlocConsumer<ContactCubit, ContactStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ContactCubit cubit = ContactCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Contacts App',
              ),
            ),
            body: ConditionalBuilder(
                condition: state is! GetContactDatabaseLoadingState,
                builder: (context) => cubit.screens[cubit.currentIndex],
                fallback: (context) => const Center(child: CircularProgressIndicator()),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_add_alt_1),
                  label: 'New Contact',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.contacts),
                  label: 'My Contacts',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
