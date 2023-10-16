import 'package:flutter/material.dart';
import 'package:flutter_pj/component/myiconbutton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_pj/component/mytextbutton.dart';
import 'package:flutter_pj/component/mytextfiled.dart';
import 'package:flutter_pj/component/mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  createUserWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      _showMyDialog('Success', 'Register successful.');
    } on FirebaseAuthException catch (e) {
      print('Failed, with error code: ${e.code}');
      print(e.message);

      if (e.code == 'invalid-email') {
        _showMyDialog('Error', 'No user found for the email.');
      } else if (e.code == 'email-already-in-use') {
        _showMyDialog('Error', 'Email already in use.');
      }
    }
  }

void _showMyDialog(String title, String message) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  void signUpUser() async {
    if (emailController.text != "" && passwordController.text != "") {
      print("It's ok");
    } else {
      print('Please input your email and password.');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 216, 247, 235),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Form(
          child: Column(
            children: [
              const Spacer(),
              Text(
                "Let start!!!\nPlease putting your name, email, password",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              

              
              const SizedBox(height: 20),
              MyTextField(
                controller: emailController,
                hintText: 'Enter your email', 
                labelText: 'Email', 
                obcureText: false),

              const SizedBox(height: 20),
              MyTextField(
                controller: passwordController,
                hintText: 'Enter your password', 
                labelText: 'Password', 
                obcureText: true), 


                const SizedBox(height: 10,),
                MyButton(onTap: createUserWithEmailAndPassword, hinText: 'sign up'),
                const SizedBox(height: 10,),
                
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                        Expanded(child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                       Expanded(child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 5,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyIconButton(imagePath: "lib/assets/image/A.icon.png"),
                    SizedBox(width: 20,),
                    MyIconButton(imagePath: "lib/assets/image/F.icon.png"),

                  ],
                ),

                const SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Already a member?', style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.displaySmall,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),),
                    const MyTextButton(lableText: 'Login now!', pageRoute: 'login',),
                  ],
                ),
              ),
              const Spacer(),

                
            ],
          ),
        ),
      ),
    );
  }
}