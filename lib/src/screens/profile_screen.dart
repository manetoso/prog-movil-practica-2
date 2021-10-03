import 'package:flutter/material.dart';
import 'package:practica_2/src/database/account_database_helper.dart';
import 'package:practica_2/src/models/account_model.dart';
import 'package:practica_2/src/screens/edit_user_screen.dart';
import 'package:practica_2/src/utils/colors_settings.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AccountDatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _databaseHelper = AccountDatabaseHelper();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: ColorSettings.colorPrimary,
      ),
      body: FutureBuilder(
          future: _databaseHelper.getAllAccounts(),
          builder: (BuildContext context,
              AsyncSnapshot<List<AccountModel>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Ocurrio un error en la petición'),
              );
            } else {
              if (snapshot.connectionState == ConnectionState.done) {
                print('>>>HERE COMES DATA!!!');
                print(snapshot.data!.first);
                return _accountList(snapshot.data!);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          }),
    );
  }

  Widget _accountList(List<AccountModel> accountInformation) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(milliseconds: 500), () {
          setState(() {});
        });
      },
      child: ListView.builder(
        itemBuilder: (BuildContext context, index) {
          AccountModel accountInfo = accountInformation[index];
          return Card(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombre:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    accountInfo.name!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Apellido paterno:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    accountInfo.lastName1!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Apellido materno:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    accountInfo.lastName2!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Número de teléfono:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    accountInfo.phoneNumber!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Email:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    accountInfo.email!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Avatar:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Center(
                  //   child: Image.asset(
                  //     accountInfo.avatar!,
                  //     width: 160,
                  //     height: 160,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  Text(
                    accountInfo.avatar!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        iconSize: 18,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditUserScreen(account: accountInfo)));
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
        itemCount: accountInformation.length,
      ),
    );
  }
}
