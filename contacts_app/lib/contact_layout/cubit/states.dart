abstract class ContactStates {}

class ContactInitialState extends ContactStates {}

class ContactChangeIndexState extends ContactStates {}

class InsertContactDatabaseState extends ContactStates {}

class GetContactDatabaseLoadingState extends ContactStates {}

class GetContactDatabaseState extends ContactStates {}

class CreateContactDatabaseState extends ContactStates {}

class DeleteContactDatabaseState extends ContactStates {}
