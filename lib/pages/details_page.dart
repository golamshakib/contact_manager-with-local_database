import 'dart:io';
import 'package:contact_manager/pages/create_contact_page.dart';
import 'package:contact_manager/providers/contact_provider.dart';
import 'package:contact_manager/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailsPage extends StatefulWidget {
  static const String routeName = '/details';

  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact details'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, CreateContactPage.routeName,
                      arguments: id)
                  .then((_) {
                setState(() {});
              });
            },
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_outlined),
          )
        ],
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) => FutureBuilder(
          future: provider.showContactId(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final contact = snapshot.data;
              return ListView(
                children: [
                  InkWell(
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.grey.shade800,
                      backgroundImage: contact!.image != null
                          ? FileImage(File(contact.image!))
                          : null,
                      child: contact.image == null
                          ? const Icon(
                              Icons.person,
                              size: 50.0,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                      child: Text(
                          '${contact.firstName} ${contact.lastName ?? ''}')),
                  const SizedBox(height: 16.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: contact.mobile == null
                                    ? null
                                    : () {
                                        _callContact(context, contact.mobile!);
                                      },
                                icon: contact.mobile == null
                                    ? Icon(
                                        Icons.call_outlined,
                                        color: Theme.of(context)
                                            .disabledColor, // Disabled icon color
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                        child: const Icon(Icons.call_outlined),
                                      ),
                              ),
                              Text(
                                'Call',
                                style: TextStyle(
                                  color: contact.mobile == null
                                      ? Theme.of(context)
                                          .disabledColor // Disabled text color
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color, // Active text color
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: contact.mobile == null
                                    ? null
                                    : () {
                                        _smsContact(context, contact.mobile!);
                                      },
                                icon: contact.mobile == null
                                    ? Icon(
                                        Icons.message_outlined,
                                        color: Theme.of(context).disabledColor,
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                        child:
                                            const Icon(Icons.message_outlined),
                                      ),
                              ),
                              Text(
                                'Text',
                                style: TextStyle(
                                  color: contact.mobile == null
                                      ? Theme.of(context).disabledColor
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: contact.email == null
                                    ? null
                                    : () {
                                        _emailContact(context, contact.email!);
                                      },
                                icon: contact.email == null
                                    ? Icon(
                                        Icons.email_outlined,
                                        color: Theme.of(context).disabledColor,
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                        child: const Icon(Icons.email_outlined),
                                      ),
                              ),
                              Text(
                                'Email',
                                style: TextStyle(
                                  color: contact.email == null
                                      ? Theme.of(context).disabledColor
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: contact.address == null
                                    ? null
                                    : () {
                                        _openMap(context, contact.address!);
                                      },
                                icon: contact.address == null
                                    ? Icon(
                                        Icons.map_outlined,
                                        color: Theme.of(context).disabledColor,
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                        child: const Icon(Icons.map_outlined),
                                      ),
                              ),
                              Text(
                                'Address',
                                style: TextStyle(
                                  color: contact.address == null
                                      ? Theme.of(context).disabledColor
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: contact.website == null
                                    ? null
                                    : () {
                                        _openBrowser(context, contact.website!);
                                      },
                                icon: contact.website == null
                                    ? Icon(
                                        Icons.web_outlined,
                                        color: Theme.of(context).disabledColor,
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                        child: const Icon(Icons.web_outlined),
                                      ),
                              ),
                              Text(
                                'Website',
                                style: TextStyle(
                                  color: contact.website == null
                                      ? Theme.of(context).disabledColor
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Contact info',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            TextButton(
                              onPressed: () {
                                _callContact(context, contact.mobile!);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.call_outlined,
                                        color: contact.mobile == null
                                            ? Colors.blue
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color,
                                      ),
                                      const SizedBox(width: 20.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            contact.mobile ??
                                                'Add phone number',
                                            style: TextStyle(
                                              color: contact.mobile == null
                                                  ? Colors.blue
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .color,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                          if (contact.group != null)
                                            Text(
                                              contact.group ?? '',
                                              style: TextStyle(
                                                color: contact.mobile == null
                                                    ? Colors.blue
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .color,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: contact.mobile == null
                                        ? null
                                        : () {
                                            _smsContact(
                                                context, contact.mobile!);
                                          },
                                    icon: const Icon(
                                      Icons.message_outlined,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                _emailContact(context, contact.email!);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.email_outlined,
                                        color: contact.email == null
                                            ? Colors.blue
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color,
                                      ),
                                      const SizedBox(width: 20.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            contact.email ?? 'Add email',
                                            style: TextStyle(
                                              color: contact.email == null
                                                  ? Colors.blue
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .color,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: contact.email == null
                                        ? null
                                        : () {
                                      _emailContact(
                                          context, contact.email!);
                                    },
                                    icon: const Icon(
                                      Icons.email_outlined,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                _openMap(context, contact.address!);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.map_outlined,
                                        color: contact.address == null
                                            ? Colors.blue
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color,
                                      ),
                                      const SizedBox(width: 20.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            contact.address ?? 'Add address',
                                            style: TextStyle(
                                              color: contact.address == null
                                                  ? Colors.blue
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .color,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: contact.address == null
                                        ? null
                                        : () {
                                      _openMap(
                                          context, contact.address!);
                                    },
                                    icon: const Icon(
                                      Icons.map_outlined,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                _openBrowser(context, contact.website!);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.web_outlined,
                                        color: contact.website == null
                                            ? Colors.blue
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color,
                                      ),
                                      const SizedBox(width: 20.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            contact.website ?? 'Add website',
                                            style: TextStyle(
                                              color: contact.website == null
                                                  ? Colors.blue
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .color,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: contact.website == null
                                        ? null
                                        : () {
                                      _openBrowser(
                                          context, contact.website!);
                                    },
                                    icon: const Icon(
                                      Icons.web_outlined,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.date_range_outlined,
                                        color: contact.dob == null
                                            ? Colors.blue
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color,
                                      ),
                                      const SizedBox(width: 20.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            contact.dob ?? 'Add date of birth',
                                            style: TextStyle(
                                              color: contact.dob == null
                                                  ? Colors.blue
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .color,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        contact.gender == 'Male'
                                            ? Icons.male_outlined
                                            : contact.gender == 'Female'
                                                ? Icons.female_outlined
                                                : Icons.person_outline,
                                        // Default icon if gender is not set
                                        color: contact.gender == null
                                            ? Colors.blue
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color,
                                      ),
                                      const SizedBox(width: 20.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            contact.gender ?? 'Add gender',
                                            style: TextStyle(
                                              color: contact.gender == null
                                                  ? Colors.blue
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .color,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Failed to get data'),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Future<void> _callContact(BuildContext context, String mobile) async {
    final url = 'tel:$mobile';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'Could not make call');
    }
  }

  Future<void> _smsContact(BuildContext context, String mobile) async {
    final url = 'sms:$mobile';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'Could not send message');
    }
  }

  Future<void> _emailContact(BuildContext context, String email) async {
    final url = 'mailto:$email';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'Could not send mail');
    }
  }

  Future<void> _openMap(BuildContext context, String address) async {
    final url;
    if (Platform.isAndroid) {
      url = 'geo:0,0?q=$address';
    } else {
      url = 'http://maps.apple.com/?q=$address';
    }
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'Could not open browser');
    }
  }

  Future<void> _openBrowser(BuildContext context, String website) async {
    final url = 'https:$website';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'Could not open browser');
    }
  }
}
