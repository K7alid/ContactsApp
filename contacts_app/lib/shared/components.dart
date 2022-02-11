import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:contacts_app/contact_layout/cubit/cubit.dart';
import 'package:flutter/material.dart';

Widget defaultTextFormField({
  required String text,
  required IconData prefix,
  IconData? suffix,
  double radius = 0.0,
  required TextInputType textInputType,
  required var controller,
  var onSubmitted,
  var onChange,
  Function()? onTap,
  required validate,
  var onSuffixPressed,
  bool isPassword = false,
}) =>
    TextFormField(
      obscureText: isPassword,
      validator: validate,
      controller: controller,
      onFieldSubmitted: onSubmitted,
      onChanged: onChange,
      onTap: onTap,
      keyboardType: textInputType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        labelText: text,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: onSuffixPressed,
              )
            : null,
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required Function() function,
  required String text,
  bool isUpperCase = true,
  double radius = 0.0,
}) =>
    Container(
      height: 40.0,
      width: width,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Color(0xffe8eaf9),
      ),
    );

Widget contactBuilder({
  required List<Map> contacts,
}) =>
    ConditionalBuilder(
      condition: contacts.isNotEmpty,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildContactItem(contacts[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: contacts.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.perm_contact_cal_outlined,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              'No Contacts Yet, Please Add Some',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );

Widget buildContactItem(Map model, context) => Padding(
  key: UniqueKey(),
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      const CircleAvatar(
        backgroundColor: Color(0xff3e4685),
        radius: 30,
        child: Text(
          '002',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
      const SizedBox(
        width: 20.0,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              model['name'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Text(
              model['phone'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      IconButton(
        onPressed: () {
          ContactCubit.get(context).deleteData(
            id: model['id'],
          );
        },
        icon: const Icon(Icons.delete,),
        color: Color(0xff3e4685),
        iconSize: 30,
      ),
    ],
  ),
);

