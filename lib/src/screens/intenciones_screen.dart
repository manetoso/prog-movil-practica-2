import 'package:flutter/material.dart';
import 'package:practica_2/src/utils/colors_settings.dart';
import 'package:url_launcher/url_launcher.dart';

class IntencionesScreen extends StatefulWidget {
  IntencionesScreen({Key? key}) : super(key: key);

  @override
  _IntencionesScreenState createState() => _IntencionesScreenState();
}

class _IntencionesScreenState extends State<IntencionesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intenciones implicitas'),
        backgroundColor: ColorSettings.colorPrimary,
      ),
      body: ListView(
        children: [
          Card(
            elevation: 8.0,
            shadowColor: Colors.black38,
            child: ListTile(
              tileColor: Colors.white10,
              title: Text('Abrir página web del tecnm en Celayuki'),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18.0,
                    color: ColorSettings.colorPrimary,
                  ),
                  Text('https://celaya.tecnm.mx/'),
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.language,
                  color: Colors.black45,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(width: 1.0),
                  ),
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                _abrirWeb();
              },
            ),
          ),
          Card(
            elevation: 8.0,
            shadowColor: Colors.black38,
            child: ListTile(
              tileColor: Colors.white10,
              title: Text('Phonik Calleichon'),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18.0,
                    color: ColorSettings.colorPrimary,
                  ),
                  Text('Cel: 4291732498'),
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.phone_android,
                  color: Colors.black45,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(width: 1.0),
                  ),
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _llamadaTelefonica,
            ),
          ),
          Card(
            elevation: 8.0,
            shadowColor: Colors.black38,
            child: ListTile(
              tileColor: Colors.white10,
              title: Text('Mezach cendation'),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18.0,
                    color: ColorSettings.colorPrimary,
                  ),
                  Text('Cel: 4291732498'),
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.sms_sharp,
                  color: Colors.black45,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(width: 1.0),
                  ),
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _enviarSms,
            ),
          ),
          Card(
            elevation: 8.0,
            shadowColor: Colors.black38,
            child: ListTile(
              tileColor: Colors.white10,
              title: Text('Ymeil cendation'),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18.0,
                    color: ColorSettings.colorPrimary,
                  ),
                  Text('To: pazuzu6@gmail.com'),
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.email_outlined,
                  color: Colors.black45,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(width: 1.0),
                  ),
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _enviarEmail,
            ),
          ),
          Card(
            elevation: 8.0,
            shadowColor: Colors.black38,
            child: ListTile(
              tileColor: Colors.white10,
              title: Text('Tekation a pikchur'),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18.0,
                    color: ColorSettings.colorPrimary,
                  ),
                  Text('Camera'),
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.black45,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(width: 1.0),
                  ),
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  _abrirWeb() async {
    const url = 'https://celaya.tecnm.mx/';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _llamadaTelefonica() async {
    const num = 'tel:4291732498';
    if (await canLaunch(num)) {
      await launch(num);
    }
  }

  _enviarSms() async {
    const num = 'sms:4291732498';
    if (await canLaunch(num)) {
      await launch(num);
    }
  }

  _enviarEmail() async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: 'pazuzu6@gmail.com',
        query: 'subject=Hola bbcito&body=Te quiero mil <3');
    var email = params.toString();
    if (await canLaunch(email)) {
      await launch(email);
    }
  }

  //_tomarFoto() {}
}
