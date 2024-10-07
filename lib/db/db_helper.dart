import 'package:contact_manager/models/contact_model.dart';
import 'package:contact_manager/utils/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DbHelper {
  final createTableContact = ''' create table $tableContact(
  $tblContactColID integer primary key autoincrement,
  $tblContactColFirstName text,
  $tblContactColLastName text,
  $tblContactColMobile text,
  $tblContactColEmail text,
  $tblContactColAddress text,
  $tblContactColWebsite text,
  $tblContactColGender text,
  $tblContactColDob text,
  $tblContactColGroup text,
  $tblContactColFavorite integer,
  $tblContactColImage text)''';

  Future<Database> _open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = path.join(rootPath, 'contact_db');
    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(createTableContact);
      },
    );
  }

  Future<int> insert(ContactModel contact) async {
    final db = await _open();
    return db.insert(tableContact, contact.toMap());
  }

  Future<List<ContactModel>> getAllContacts() async {
    final db = await _open();
    final mapList = await db.query(tableContact);
    return List.generate(mapList.length, (index) =>
        ContactModel.fromMap(mapList[index]));
  }

  Future<List<ContactModel>> getAllFavorites() async {
    final db = await _open();
    final mapList = await db.query(tableContact, where: '$tblContactColFavorite = ?', whereArgs: [1]);
    return List.generate(mapList.length, (index) =>
        ContactModel.fromMap(mapList[index]));
  }

  Future<ContactModel> getContactById(int id) async {
    final db = await _open();
    final mapList = await db.query(tableContact, where: '$tblContactColID = ?', whereArgs: [id]);
    return ContactModel.fromMap(mapList.first);
  }

  Future<int> updateFavorite(int id, int value) async {
    final db = await _open();
    return db.update(tableContact, {tblContactColFavorite: value}, where: '$tblContactColID = ?', whereArgs: [id]);
  }

  Future<int> updateContact(ContactModel contact) async {
    final db = await _open();
    return db.update(tableContact, contact.toMap(), where: '$tblContactColID = ?', whereArgs: [contact.id]);
  }

  Future<int> deleteContact(int id) async {
    final db =await _open();
    return db.delete(tableContact, where: '$tblContactColID = ?', whereArgs: [id]);
  }
}
