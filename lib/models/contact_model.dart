import 'package:contact_manager/utils/constants.dart';

class ContactModel {
  int? id;
  String? image;
  String firstName;
  String? lastName;
  String? mobile;
  String? email;
  String? address;
  String? dob;
  String? gender;
  bool favorite;
  String? website;
  String? group;

  ContactModel({
    this.id,
    this.image,
    required this.firstName,
    this.lastName,
    this.mobile,
    this.email,
    this.address,
    this.dob,
    this.gender,
    this.favorite = false,
    this.website,
    this.group,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblContactColFirstName: firstName,
      tblContactColLastName: lastName,
      tblContactColMobile: mobile,
      tblContactColEmail: email,
      tblContactColAddress: address,
      tblContactColWebsite: website,
      tblContactColGender: gender,
      tblContactColDob: dob,
      tblContactColGroup: group,
      tblContactColImage: image,
      tblContactColFavorite: favorite ? 1 : 0,
    };
    return map;
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map[tblContactColID],
      firstName: map[tblContactColFirstName],
      lastName: map[tblContactColLastName],
      mobile: map[tblContactColMobile],
      email: map[tblContactColEmail],
      address: map[tblContactColAddress],
      website: map[tblContactColWebsite],
      gender: map[tblContactColGender],
      dob: map[tblContactColDob],
      group: map[tblContactColGroup],
      image: map[tblContactColImage],
      favorite: map[tblContactColFavorite] == 0 ? false : true,
    );
  }
}
