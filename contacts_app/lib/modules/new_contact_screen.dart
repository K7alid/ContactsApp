import 'package:contacts_app/contact_layout/cubit/cubit.dart';
import 'package:contacts_app/contact_layout/cubit/states.dart';
import 'package:contacts_app/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewContactScreen extends StatelessWidget {
  NewContactScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactCubit, ContactStates>(
        listener: (context, state){},
        builder: (context, state)
        {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Add New Contact',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                          text: 'Name',
                          prefix: Icons.person,
                          textInputType: TextInputType.name,
                          controller: nameController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'name must not be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                          text: 'Phone',
                          prefix: Icons.phone,
                          textInputType: TextInputType.phone,
                          controller: phoneController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'phone number must not be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        defaultButton(
                          background: const Color(0xff3e4685),
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ContactCubit.get(context).insertToDatabase(
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          text: 'Save',
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
    );
  }
}
