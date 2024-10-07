import 'package:contact_manager/customwidgets/contact_item_view.dart';
import 'package:contact_manager/models/contact_model.dart';
import 'package:contact_manager/pages/create_contact_page.dart';
import 'package:contact_manager/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentBottomAppBarIndex = 0;

  @override
  void didChangeDependencies() {
    context.read<ContactProvider>().showAllContacts();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                _currentBottomAppBarIndex = value;
              });
              _currentBottomAppBarIndex == 0
                  ? context.read<ContactProvider>().showAllContacts()
                  : context.read<ContactProvider>().showAllFavoriteContacts();
            },
            selectedItemColor: Colors.yellow,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            currentIndex: _currentBottomAppBarIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: 'All Contacts'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorites'),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreateContactPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.contactList.length,
          itemBuilder: (context, index) {
            final ContactModel contact = provider.contactList[index];
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                color: Colors.red,
                padding: const EdgeInsets.only(right: 20.0),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (_) {
                provider.deleteContact(contact.id!);
              },
              confirmDismiss: (_) {
                return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Delete ${contact.firstName}?'),
                          content: const Text(
                              'This contact will be permanently delete from your device'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ));
              },
              child: ContactItemView(
                contact: contact,
                onFavBtnClicked: () {
                  provider.showUpdateFavorite(contact);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
