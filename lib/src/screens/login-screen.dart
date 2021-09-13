import 'package:flutter/material.dart';
import 'package:practica_2/src/screens/dash_board_screen.dart';
import 'package:practica_2/src/utils/colors_settings.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var isLoading = false;
  TextEditingController txtEmailCon = TextEditingController();
  TextEditingController txtPwdCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextFormField txtEmail = TextFormField(
      controller: txtEmailCon,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Introduce el email, por ejemplo ¿no?',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)),
    );
    TextFormField txtPwd = TextFormField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      maxLength: 6,
      decoration: InputDecoration(
          hintStyle:
              TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
          hintText: 'Introduce la contraseña, por ejemplo ¿no?',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)),
    );
    ElevatedButton btnLogin = ElevatedButton(
        style: ElevatedButton.styleFrom(primary: ColorSettings.colorButton),
        onPressed: () {
          print(txtEmailCon);
          isLoading = true;
          setState(() {});
          Future.delayed(Duration(seconds: 1), () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DashBoardScreen()));
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Icon(Icons.login), Text('Validar Usuario uwur')],
        ));

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/space-boy.jpg'), fit: BoxFit.fill)),
        ),
        Card(
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                txtEmail,
                SizedBox(
                  height: 5,
                ),
                txtPwd,
                btnLogin
              ],
            ),
          ),
        ),
        /*
        Positioned(
          child: Image.asset(
            'assets/',
            width: 150,
          ),
          top: 180,
        )
        */
        Positioned(
          child: isLoading == true ? CircularProgressIndicator() : Container(),
          top: 180,
        )
      ],
    );
  }
}
