import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateAccountForm extends StatefulWidget {
  @override
  _CreateAccountFormState createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final _formKey = GlobalKey<FormState>();
  String _emailAddress = '';
  String _password = '';
  String _username = '';
  late int _phoneNumber;
  bool _obscureText = true;
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> authErrorHandling(String text, BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 6.0),
                child: Image.network(
                  'http://image.flaticon.com/icons/png/128/564/564619.png',
                  width: 20,
                  height: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Error Occurred'),
              )
            ],
          ),
          content: Text(
            text,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      try {
        await _auth
            .createUserWithEmailAndPassword(
                email: _emailAddress.toLowerCase().trim(),
                password: _password.trim())
            .then((value) =>
                Navigator.popUntil(context, ModalRoute.withName("/")));
      } catch (error) {
        authErrorHandling(
            "The email address is already in use by another account.", context);
        print('error occurred ${error}');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                key: ValueKey('username'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Username cannot be left blank';
                  } else {
                    return null;
                  }
                },
                textInputAction: TextInputAction.next,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(_phoneNumberFocusNode),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  filled: true,
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Username',
                  fillColor: Colors.grey.shade200,
                ),
                onSaved: (value) {
                  _username = value!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                key: ValueKey('phone number'),
                focusNode: _phoneNumberFocusNode,
                validator: (value) {
                  if (value!.isEmpty || value.length < 8) {
                    return 'Please enter a valid phone number';
                  } else {
                    return null;
                  }
                },
                textInputAction: TextInputAction.next,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(_emailFocusNode),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  filled: true,
                  prefixIcon: Icon(Icons.phone),
                  labelText: 'Phone Number',
                  fillColor: Colors.grey.shade200,
                ),
                onSaved: (value) {
                  _phoneNumber = int.parse(value!);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                key: ValueKey('email'),
                focusNode: _emailFocusNode,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address';
                  } else {
                    return null;
                  }
                },
                textInputAction: TextInputAction.next,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(_passwordFocusNode),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  filled: true,
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email Address',
                  fillColor: Colors.grey.shade200,
                ),
                onSaved: (value) {
                  _emailAddress = value!;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                key: ValueKey('Password'),
                validator: (value) {
                  if (value!.isEmpty || value.length < 4) {
                    return 'Please enter a valid Password';
                  } else {
                    return null;
                  }
                },
                focusNode: _passwordFocusNode,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  filled: true,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  labelText: 'Password',
                  fillColor: Colors.grey.shade200,
                ),
                onSaved: (value) {
                  _password = value!;
                },
                obscureText: _obscureText,
                onEditingComplete: null,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              letterSpacing: 2.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.person,
                            size: 20,
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      onPressed: _submitForm,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
