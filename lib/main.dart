import 'package:contact_manager/pages/details_page.dart';
import 'package:contact_manager/pages/home_page.dart';
import 'package:contact_manager/pages/create_contact_page.dart';
import 'package:contact_manager/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ContactProvider(),
      child: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Contact Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        CreateContactPage.routeName: (context) => const CreateContactPage(),
        DetailsPage.routeName: (context)=> const DetailsPage(),
      },
    );
  }
}
