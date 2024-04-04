import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mopidati/utiles/constants.dart';
import 'package:mopidati/widgets/my_button_widget.dart';
import 'package:mopidati/widgets/text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  bool obscureText = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    print("Email -----------------------");
    print(args);
    emailController.text = (args as String);
    return Scaffold(
      appBar: AppBar(
        title: const Text("إنشاء حساب "),
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Form(
          key: form,
          autovalidateMode: AutovalidateMode.disabled,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "إنشاء حساب",
                  ),
                  const SizedBox(height: 30),
                  TextFormFieldWidget(
                      keyboardType: TextInputType.emailAddress,
                      yourController: emailController,
                      hintText: 'أدخل بريدك الالكتروني',
                      validator: (value) {
                        //     return (!value.contains('@')) ? 'Use the @ char.' : null;
                      }),
                  const SizedBox(height: 20),
                  TextFormFieldWidget(
                      keyboardType: TextInputType.name,
                      yourController: nameController,
                      hintText: 'أدخل  اسمك ',
                      validator: (value) {
                        return (value.length < 2) ? 'قصير جدا ' : null;
                      }),
                  const SizedBox(height: 20),
                  TextFormFieldWidget(
                      keyboardType: TextInputType.emailAddress,
                      obscureText: obscureText,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: obscureText
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                      yourController: passwordController,
                      hintText: 'أدخل كلمة السر ',
                      validator: (value) {
                        return (value.length < 2) ? 'قصير جدا ' : null;
                      }),
                  const SizedBox(height: 20),
                  ButtonWidget(
                      child: const Text('أنشئ الحساب'),
                      onPressed: () async {
                        try {
                          if (form.currentState?.validate() ?? false) {
                            String email = emailController.text;
                            String name = nameController.text;
                            UserCredential result = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text);
                            print(result);
                            //firstore firebase
                            if (FirebaseAuth.instance.currentUser != null) {
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .set({
                                "name": name,
                                "email": email,
                              });
                              print("finish write");
                            } else {
                              print('non fire store');
                            }
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/home", ModalRoute.withName('/'));
                          }
                        } catch (e) {
                          if (e is FirebaseException) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.message ?? "")));
                          }
                        }
                      }),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text("لديك حساب ؟ سجل دخول"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
