import 'package:contacts_app/contact_layout/cubit/states.dart';
import 'package:contacts_app/modules/my_contacts_screen.dart';
import 'package:contacts_app/modules/new_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class ContactCubit extends Cubit<ContactStates> {
  ContactCubit() : super(ContactInitialState());

  static ContactCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    NewContactScreen(),
    MyContactsScreen(),
  ];

  void changeIndex(index) {
    currentIndex = index;
    emit(ContactChangeIndexState());
  }

  late Database dataBase;
  List<Map> myContacts = [];

  void createContactDatabase() {
    openDatabase(
      'contact.db',
      version: 1,
      onCreate: (dataBase, version) {
        print('database created');
        dataBase
            .execute(
                'CREATE TABLE contacts (id INTEGER PRIMARY KEY, name TEXT, phone TEXT, status TEXT)')
            .then((value) {
          print('the table created');
        }).catchError((error) {
          print('the error is ${error.toString()}');
        });
      },
      onOpen: (dataBase) {
        getDataFromDatabase(dataBase);
        print('database opened');
      },
    ).then((value) {
      dataBase = value;
      emit(CreateContactDatabaseState());
    });
  }

  insertToDatabase({
    required String name,
    required String phone,
  }) async {
    await dataBase.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO contacts (name, phone, status) VALUES ("$name","$phone","new")')
          .then((value) {
        print('$value inserted successfully');
        emit(InsertContactDatabaseState());
        getDataFromDatabase(dataBase);
      }).catchError((error) {
        print('this ${error.toString()} happened when insert data');
      });
    });
  }

  void getDataFromDatabase(dataBase) {
    myContacts = [];
    emit(GetContactDatabaseLoadingState());
    dataBase.rawQuery('SELECT * FROM contacts').then((value) {
      myContacts = value;
      emit(GetContactDatabaseState());
    });
  }

  void deleteData({
    required int id,
  }) async {
    dataBase.rawUpdate(
      'DELETE FROM contacts WHERE id = ?',
      [id],
    ).then((value) {
      getDataFromDatabase(dataBase);
      emit(DeleteContactDatabaseState());
    });
  }
}
