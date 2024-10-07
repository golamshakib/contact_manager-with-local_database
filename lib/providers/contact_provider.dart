import 'package:contact_manager/db/db_helper.dart';
import 'package:contact_manager/models/contact_model.dart';
import 'package:flutter/material.dart';

class ContactProvider with ChangeNotifier{
  final _db = DbHelper();

  List<ContactModel> _contactList= [];

  List get contactList => _contactList;

  Future<void> insertContact (ContactModel contact) async {
    final rowId = await _db.insert(contact);
    contact.id = rowId;
    _contactList.add(contact);
    notifyListeners();
  }

  showAllContacts() async {
    _contactList =  await _db.getAllContacts();
    notifyListeners();
  }

  showAllFavoriteContacts() async {
    _contactList =  await _db.getAllFavorites();
    notifyListeners();
  }

  Future<ContactModel> showContactId(int id) {
    return _db.getContactById(id);
  }

  Future<void> showUpdateFavorite(ContactModel contact) async {
    final newFavoriteValue = contact.favorite ? 0 : 1;
    await _db.updateFavorite(contact.id!, newFavoriteValue);
    final position = _contactList.indexOf(contact);
    _contactList[position].favorite = !_contactList[position].favorite;
    notifyListeners();
  }

  Future<void> showUpdateContact(ContactModel contact) async {
    await _db.updateContact(contact);
    notifyListeners();
  }

  Future<int> deleteContact( int id) {
    return _db.deleteContact(id);
  }
}
