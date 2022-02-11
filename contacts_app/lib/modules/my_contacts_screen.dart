import 'package:contacts_app/contact_layout/cubit/cubit.dart';
import 'package:contacts_app/contact_layout/cubit/states.dart';
import 'package:contacts_app/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyContactsScreen extends StatelessWidget {
  const MyContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactCubit, ContactStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var myContacts = ContactCubit.get(context).myContacts;
        return contactBuilder(
          contacts: myContacts,
        );
      },
    );
  }
}
