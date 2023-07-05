import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordCheckController = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    const SizedBox(height: 30.0),
                    TextFormField(
                      validator: (String? value) {


                        if (value!.isEmpty) {
                          return "Please enter your name";
                        }
                        else{
                          if(!RegExp(r'^(?=(?:.*[a-zA-Z]){3})(?=(?:.*[0-9]){3})[a-zA-Z0-9]{6,}$').hasMatch(value))
                            {
                              return "Username is invalid";
                            }
                        }
                        return null;
                      },

                      controller: _usernameController,
                      decoration: const InputDecoration(
                        filled: true,
                        labelText: 'Username',
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;

                      },
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        filled: true,
                        labelText: 'Password',
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        }
                        if(value !=_passwordController.text)
                          {
                            return "Confirm Password doesn't match Password";
                          }
                        return null;

                      },
                      controller: _passwordCheckController,
                      decoration: const InputDecoration(
                        filled: true,
                        labelText: 'Confirm Password',
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please enter your Email Address";
                        }
                        return null;

                      },
                      controller: _emailController,
                      decoration: const InputDecoration(
                        filled: true,
                        labelText: 'Email Address',
                      ),

                    ),
                    OverflowBar(
                        alignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ElevatedButton(
                            style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 18),
                                backgroundColor: Colors.grey,
                                primary: Colors.black),
                            child: const Text('SIGN UP'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  Navigator.pop(context);
                                });
                              }
                            },
                          ),
                        ])
                  ],
                ))));
  }
}
