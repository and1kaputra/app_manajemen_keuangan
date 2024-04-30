import 'package:app_manajemen_keuangan/config/session.dart';
import 'package:app_manajemen_keuangan/presentation/page/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Text('Home Page'),
            IconButton(
              onPressed: () {
                Session.clearUser();
                Get.off(() => const LoginPage());
              }, 
              icon: Icon(Icons.logout)
           ),
         ],
      )),
    );
  }
}