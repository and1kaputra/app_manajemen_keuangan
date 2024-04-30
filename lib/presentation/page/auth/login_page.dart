import 'package:app_manajemen_keuangan/config/app_asset.dart';
import 'package:app_manajemen_keuangan/config/app_color.dart';
import 'package:app_manajemen_keuangan/data/source/source_user.dart';
import 'package:app_manajemen_keuangan/presentation/page/auth/register_page.dart';
import 'package:app_manajemen_keuangan/presentation/page/home_page.dart';
import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final formKey = GlobalKey<FormState>(); // menerapkan validator di email agar jangan kosong saat mengklik tombol Login
  login() async {
    if (formKey.currentState!.validate()) {
      bool success = await SourceUser.login(
        controllerEmail.text, 
        controllerPassword.text,
    );
    if (success) {
        DInfo.dialogSuccess('Berhasil Login');
        DInfo.closeDialog(
          actionAfterClose: () {
            Get.off(() => const HomePage());
          }
        );
    }else {
        DInfo.dialogError('Gagal Login');
        DInfo.closeDialog();
      }
    }
  }
  
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background, // untuk menambahkan warna background pada tampilan login
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight, // perpaduan antara mainaxis center dengan menggunakan constraint
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DView.nothing(),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Image.asset(AppAsset.logo),
                          DView.spaceHeight(40),
                          TextFormField(  // karena validator ada di TextFormField
                            controller: controllerEmail,
                            validator: (value)=>
                                value==''?'Jangan Kosong':null, // untuk validator
                            autovalidateMode: 
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: AppColor.primary.withOpacity(0.5),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'email',
                              isDense: true,
                              contentPadding:
                                  const EdgeInsets.symmetric(
                                    horizontal: 20,vertical: 16,
                              ),
                            ),
                          ),
                          DView.spaceHeight(),
                          TextFormField(
                            controller: controllerPassword,
                            validator: (value)=>
                                value==''?'Jangan Kosong':null,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              fillColor: AppColor.primary.withOpacity(0.5),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'password',
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                              ),
                            ),
                          ),
                          DView.spaceHeight(30),
                          Material(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              onTap:()=>login(),
                              borderRadius: BorderRadius.circular(30), // memberikan efek ripple yang sama saat di click
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40,vertical: 16),
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                 ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Belum punya akun?',
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const RegisterPage());
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }
}