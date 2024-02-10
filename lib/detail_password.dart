import 'dart:developer';

import 'package:cat_miaunder/models/password.dart';
import 'package:cat_miaunder/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'add_update_password.dart';

class DetailDialog extends StatelessWidget {
  final Password password;
  final ViewModel viewModel;

  const DetailDialog({required this.password, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          const SizedBox(
            height: 270,
            width: 280,
            child: Image(
              image: AssetImage('assets/dialog_border.png'),
              fit: BoxFit.fill,
            ),
          ),
          AlertDialog(
            title: Text(password.serviceWebsiteName, style: Theme.of(context).textTheme.titleLarge),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.13,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email: ${password.email}'),
                    Text('Username: ${password.username}'),
                    Text('Password: ${password.password}'),
                    Text('Note: ${password.note}'),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {return DeleteConfirmationDialog(password: password, viewModel: viewModel);},
                  );
                },
                child: const Text('Delete'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddUpdatePasswordPage(password: password)));
                },
                child: const Text('Edit'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close', style: Theme.of(context).textTheme.labelLarge),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DeleteConfirmationDialog extends StatelessWidget {
  final Password password;
  final ViewModel viewModel;

  const DeleteConfirmationDialog({required this.password, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          const SizedBox(
            height: 190,
            width: 280,
            child: Image(
              image: AssetImage('assets/dialog_border.png'),
              fit: BoxFit.fill,
            ),
          ),
          AlertDialog(
            title: const Text('Confirm Delete'),
            content: Text('Are you sure you want to delete ${password.serviceWebsiteName}?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).popUntil(ModalRoute.withName(Navigator.defaultRouteName)); // close all dialogs
                  try {
                    viewModel.deleteItem(password.id);
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
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No', style: Theme.of(context).textTheme.labelLarge),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
