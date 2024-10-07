import 'package:contact_manager/models/contact_model.dart';
import 'package:contact_manager/pages/details_page.dart';
import 'package:flutter/material.dart';

class ContactItemView extends StatelessWidget {
  const ContactItemView({
    super.key,
    required this.contact,
    required this.onFavBtnClicked,
  });

  final ContactModel contact;
  final VoidCallback onFavBtnClicked;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.pushNamed(context, DetailsPage.routeName, arguments: contact.id);
      },
      title: Text(contact.firstName),
      trailing: IconButton(
          onPressed: onFavBtnClicked,
          icon: Icon(contact.favorite ? Icons.favorite : Icons
              .favorite_border_outlined)),
    );
  }
}
