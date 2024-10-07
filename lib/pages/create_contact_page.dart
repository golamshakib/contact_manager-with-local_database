import 'dart:io';
import 'package:contact_manager/customwidgets/text_button_widget.dart';
import 'package:contact_manager/models/contact_model.dart';
import 'package:contact_manager/providers/contact_provider.dart';
import 'package:contact_manager/utils/constants.dart';
import 'package:contact_manager/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../customwidgets/custom_date_picker_widget.dart';

class CreateContactPage extends StatefulWidget {
  static const String routeName = '/create';

  const CreateContactPage({super.key});

  @override
  State<CreateContactPage> createState() => _CreateContactPageState();
}

class _CreateContactPageState extends State<CreateContactPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _addressController = TextEditingController();
  final _websiteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate = DateTime.now();
  String? _imagePath;
  int? id;
  Gender? _gender;
  String? _group;
  bool _showEmailTextButton = false;
  bool _showDobTextButton = false;
  bool _showAddressTextButton = false;
  bool _showWebsiteTextButton = false;
  bool _showEmailField = false;
  bool _showDobField = false;
  bool _showAddressField = false;
  bool _showWebsiteField = false;
  bool _isDataLoaded = true;

  @override
  void didChangeDependencies() {
    if (_isDataLoaded) {
      final arg = ModalRoute.of(context)!.settings.arguments;
      if (arg != null) {
        id = arg as int;
        context.read<ContactProvider>().showContactId(id!).then((contact) {
          setState(() {
            _firstNameController.text = contact.firstName;
            _lastNameController.text = contact.lastName ?? '';
            _mobileController.text = contact.mobile ?? '';
            _emailController.text = contact.email ?? '';
            _addressController.text = contact.address ?? '';
            _websiteController.text = contact.website ?? '';
            _dobController.text = contact.dob ?? '';
            _imagePath = contact.image;
            _group = contact.group;
            if (contact.gender != null) {
              _gender = contact.gender == Gender.Male.name
                  ? Gender.Male
                  : Gender.Female;
            }
          });
        });
      }
      _isDataLoaded = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create contact'),
        actions: [
          IconButton(
            onPressed: _save,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
          children: [
            const SizedBox(height: 20.0),
            SafeArea(
              child: Column(
                children: [
                  InkWell(
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.grey.shade800,
                      backgroundImage: _imagePath != null
                          ? FileImage(File(_imagePath!))
                          : null,
                      child: _imagePath == null
                          ? const Icon(Icons.add_photo_alternate_outlined)
                          : null,
                    ),
                    onTap: () {
                      _showImageSourceSelectionDialog(context);
                    },
                  ),
                  const SizedBox(height: 8.0),
                  TextButtonWidget(
                      text: 'Add picture',
                      onPressed: () {
                        _showImageSourceSelectionDialog(context);
                      })
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  hintText: 'First name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide the name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  hintText: 'Last name (Optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: IntlPhoneField(
                controller: _mobileController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Phone (Mobile)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                initialCountryCode: 'BD',
                validator: (value) {
                  if (value == null || value.number.isEmpty) {
                    return 'Please provide the number';
                  }
                  return null;
                },
              ),
            ),
            TextButtonWidget(
              text: 'Add phone',
              onPressed: () {},
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Select gender',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
                Radio<Gender>(
                  value: Gender.Male,
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
                Text(Gender.Male.name),
                Radio<Gender>(
                  value: Gender.Female,
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
                Text(Gender.Female.name),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<String>(
                value: _group,
                hint: const Text('Select group'),
                items: groupList
                    .map((group) => DropdownMenuItem<String>(
                        value: group, child: Text(group)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _group = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
              child: !_showEmailField
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showEmailField = true;
                          _showEmailTextButton = true;
                        });
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.email_outlined),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Add email')
                        ],
                      ),
                    )
                  : Container(),
            ),
            if (_showEmailField)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
            if (_showEmailTextButton)
              TextButtonWidget(
                text: 'Add email',
                onPressed: () {},
              ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: !_showDobField
                  ? ElevatedButton(
                      onPressed: () {
                        showCustomDatePicker(context, _selectedDate!,
                            (selectedDate) {
                          setState(() {
                            _selectedDate = selectedDate;
                            _dobController.text =
                                DateFormat.yMMMd().format(_selectedDate!);
                            _showDobField = true;
                            _showDobTextButton = true;
                          });
                        });
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.today_outlined),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Add significant date')
                        ],
                      ),
                    )
                  : Container(),
            ),
            if (_showDobField)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _dobController,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Significant date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
            if (_showDobTextButton)
              TextButtonWidget(
                text: 'Add significant date',
                onPressed: () {},
              ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: !_showAddressField
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showAddressField = true;
                          _showAddressTextButton = true;
                        });
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on_outlined),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Add address')
                        ],
                      ),
                    )
                  : Container(),
            ),
            if (_showAddressField)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
            if (_showAddressTextButton)
              TextButtonWidget(
                text: 'Add address',
                onPressed: () {},
              ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: !_showWebsiteField
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showWebsiteField = true;
                          _showWebsiteTextButton = true;
                        });
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.web),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('Add website')
                        ],
                      ),
                    )
                  : Container(),
            ),
            if (_showWebsiteField)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _websiteController,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Website',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
            if (_showWebsiteTextButton)
              TextButtonWidget(
                text: 'Add Website',
                onPressed: () {},
              ),
          ],
        ),
      ),
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final contact = ContactModel(
        image: _imagePath,
        firstName: _firstNameController.text,
        lastName:
            _lastNameController.text.isEmpty ? null : _lastNameController.text,
        mobile: _mobileController.text.isEmpty ? null : _mobileController.text,
        gender: _gender?.name,
        group: _group,
        email: _emailController.text.isEmpty ? null : _emailController.text,
        dob: _dobController.text.isEmpty ? null : _dobController.text,
        address:
            _addressController.text.isEmpty ? null : _addressController.text,
        website:
            _websiteController.text.isEmpty ? null : _websiteController.text,
      );
      if (id != null) {
        contact.id = id;
        context
            .read<ContactProvider>()
            .showUpdateContact(contact)
            .then((value) {
          showMsg(context, 'Contact Updated');
          Navigator.pop(context);
        }).catchError((error) {
          print('Error inserting contact: $error'); // Log the error
          showMsg(context, 'Could not update');
        });
      } else {
        context.read<ContactProvider>().insertContact(contact).then((value) {
          showMsg(context, 'Contact Saved');
          Navigator.pop(context);
        }).catchError((error) {
          print('Error inserting contact: $error'); // Log the error
          showMsg(context, 'Could not save');
        });
      }
    }
  }

  void _showImageSourceSelectionDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text('Camera'),
                  onTap: () async {
                    await _openImagePicker(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Center(
                child: ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () async {
                    await _openImagePicker(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openImagePicker(ImageSource source) async {
    final xFile = await ImagePicker().pickImage(
      source: source,
      maxWidth: 600,
      maxHeight: 600,
      imageQuality: 85,
    );
    if (xFile != null) {
      setState(() {
        _imagePath = xFile.path;
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _websiteController.dispose();
    super.dispose();
  }
}
