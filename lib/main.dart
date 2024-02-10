import 'dart:developer';

import 'package:cat_miaunder/colors.dart';
import 'package:cat_miaunder/models/password.dart';
import 'package:cat_miaunder/view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'add_update_password.dart';
import 'detail_password.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme(
          primary: CustomColor.bestPink.color,
          secondary: CustomColor.fadedBlue.color,
          background: CustomColor.smoothBlack.color,
          surface: CustomColor.smoothBlack.color,
          onPrimary: CustomColor.white.color,
          onSecondary: CustomColor.white.color,
          onBackground: CustomColor.white.color,
          onSurface: CustomColor.white.color,
          error: Colors.red,
          onError: CustomColor.white.color,
          brightness: Brightness.dark,
        ),
        textTheme: TextTheme(
          displayLarge:
              TextStyle(fontFamily: 'Oxanium', color: CustomColor.white.color),
          displayMedium: TextStyle(
              fontFamily: 'Oxanium', color: CustomColor.fadedBlue.color),
          displaySmall: TextStyle(
              fontFamily: 'Oxanium', color: CustomColor.fadedBlue.color),
          titleLarge:
              TextStyle(fontFamily: "Oxanium", color: CustomColor.white.color, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(
              fontFamily: "Oxanium", color: CustomColor.white.color, fontWeight: FontWeight.bold),
          titleSmall: TextStyle(
              fontFamily: "Oxanium", color: CustomColor.fadedBlue.color),
          bodyLarge:
              TextStyle(fontFamily: "Oxanium", color: CustomColor.gray.color),
          bodyMedium:
              TextStyle(fontFamily: "Oxanium", color: CustomColor.gray.color),
          bodySmall:
              TextStyle(fontFamily: "Oxanium", color: CustomColor.white.color),
          labelLarge:
              TextStyle(fontFamily: "Oxanium", color: CustomColor.fadedBlue.color),
          labelMedium: TextStyle(
              fontFamily: "Oxanium", color: CustomColor.gray.color),
          labelSmall: TextStyle(
              fontFamily: "Oxanium", color: CustomColor.fadedBlue.color),
          headlineLarge:
              TextStyle(fontFamily: "Oxanium", color: CustomColor.white.color),
          headlineMedium:
              TextStyle(fontFamily: "Oxanium", color: CustomColor.white.color),
          headlineSmall:
              TextStyle(fontFamily: "Oxanium", color: CustomColor.white.color),
        ),
        cardTheme: CardTheme(
          color: CustomColor.smoothBlack.color,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 5,
        ),
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.transparent
        ),
        dialogTheme: const DialogTheme(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        )
        // useMaterial3: true,
      ),

      //home app
      home: Scaffold(
        appBar: AppBar(
            title: Center(
              child: Image.asset('assets/logo.png', height: 40,),
        )),
        body: const HomePage(),
        floatingActionButton: const AddItemButton(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    try {
      return Consumer<ViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.list.isEmpty) {
            return const Center(
              child: Text('No data available.'),
            );
          }

          return ListView.builder(
            itemCount: viewModel.list.length,
            itemBuilder: (context, index) {
              Password password = viewModel.list[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                // list elements
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/card_border.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: ListTile(
                    title: Text(password.serviceWebsiteName, style: Theme.of(context).textTheme.titleMedium),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Username: ${password.username}', style: Theme.of(context).textTheme.bodyMedium),
                        Text('Password: ${password.password}', style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext builder) {
                          return DetailDialog(password: password, viewModel: viewModel);
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      );
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
      return Container();
    }
  }
}

class AddItemButton extends StatelessWidget {
  const AddItemButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.transparent,
      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const AddUpdatePasswordPage(),),);},
      tooltip: 'Add Item',
      child: Material(
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,
        child: Ink.image(
          image: const AssetImage('assets/floating_btn_background.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
