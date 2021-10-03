import 'package:flutter/material.dart';
import 'package:practica_2/src/utils/colors_settings.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DASHBOARD'),
        backgroundColor: ColorSettings.colorPrimary,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://scontent.fcyw5-1.fna.fbcdn.net/v/t1.6435-9/90541481_2914995071872840_3892141879516463104_n.jpg?_nc_cat=102&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeEb5bz2E4lxhHjr3GRLT7FSBVkxtC9n--oFWTG0L2f76lIe5VeqvuW__yrnBDIaQM4Ib0KXexaXpLZEwPW9jOuW&_nc_ohc=-ytztjRxbvwAX_OODD5&tn=rrn1cXSixqKUZQFY&_nc_ht=scontent.fcyw5-1.fna&oh=3f7706730ce01bb9feec5197e34fbf65&oe=61618A06'),
              ),
              accountName: Text('Emmanuel'),
              accountEmail: Text('manetoso@hotmail.com'),
              decoration: BoxDecoration(color: ColorSettings.colorPrimary),
            ),
            ListTile(
              title: Text('Propinas'),
              subtitle: Text('Descripción corta'),
              leading: Icon(Icons.monetization_on),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/propinas');
              },
            ),
            ListTile(
              title: Text('Páctica 2'),
              subtitle: Text('Descripción corta'),
              leading: Icon(Icons.ac_unit),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              title: Text('Intenciones'),
              subtitle: Text('Intenciones Implicitas'),
              leading: Icon(Icons.phone_android),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/intenciones');
              },
            ),
            ListTile(
              title: Text('Notas'),
              subtitle: Text('CRUD Notas'),
              leading: Icon(Icons.note),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/notas');
              },
            ),
            ListTile(
              title: Text('Perfil'),
              subtitle: Text('Información de cuenta'),
              leading: Icon(Icons.person),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile-info');
              },
            ),
          ],
        ),
      ),
    );
  }
}
