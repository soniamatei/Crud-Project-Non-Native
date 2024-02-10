import 'dart:developer';

import 'package:cat_miaunder/colors.dart';
import 'package:cat_miaunder/models/password.dart';
import 'package:cat_miaunder/view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const CustomTextField({Key? key, required this.labelText, required this.controller,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/input_border.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        ),
      ),
    );
  }
}


class AddUpdatePasswordPage extends StatefulWidget {
  final Password? password;

  const AddUpdatePasswordPage({Key? key, this.password}) : super(key: key);

  @override
  _AddUpdatePasswordPageState createState() => _AddUpdatePasswordPageState();
}

class _AddUpdatePasswordPageState extends State<AddUpdatePasswordPage> {
  late TextEditingController serviceWebsiteNameController;
  late TextEditingController emailController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();

    // populate with values if password given
    serviceWebsiteNameController = TextEditingController(text: widget.password?.serviceWebsiteName ?? '');
    emailController = TextEditingController(text: widget.password?.email ?? '');
    usernameController = TextEditingController(text: widget.password?.username ?? '');
    passwordController = TextEditingController(text: widget.password?.password ?? '');
    noteController = TextEditingController(text: widget.password?.note ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.centerLeft,
          child: Image.asset('assets/logo.png', height: 40)
      )),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Expanded(
          child: ListView(

            children: [
              CustomTextField(labelText: "Service/Web provider", controller: serviceWebsiteNameController),
              const SizedBox(height: 20),
              CustomTextField(labelText: "Email", controller: emailController),
              const SizedBox(height: 20),
              CustomTextField(labelText: "Username", controller: usernameController),
              const SizedBox(height: 20),
              CustomTextField(labelText: "Password", controller: passwordController),
              const SizedBox(height: 20),
              CustomTextField(labelText: "Note", controller: noteController),
              const SizedBox(height: 50),
              FloatingActionButton(
                mini: true,
                onPressed: () {

                  try {
                    if (widget.password == null) {
                      // add option
                      Provider.of<ViewModel>(context, listen: false).addItem(
                        serviceWebsiteName: serviceWebsiteNameController.text,
                        email: emailController.text,
                        username: usernameController.text,
                        password: passwordController.text,
                        note: noteController.text,
                      );
                    } else {
                      // update option
                      Provider.of<ViewModel>(context, listen: false).updateItem(
                        id: widget.password!.id,
                        serviceWebsiteName: serviceWebsiteNameController.text,
                        email: emailController.text,
                        username: usernameController.text,
                        password: passwordController.text,
                        note: noteController.text,
                      );// add progress indicator or error handling logic
                    }
                  }
                  catch (error) {
                    log(error.toString());
                    Fluttertoast.showToast(
                      msg: error.toString().split(": ").elementAt(1),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    );
                  }

                  Navigator.pop(context);
                },
                child: Text(widget.password == null ? 'Add Password' : 'Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
