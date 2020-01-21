import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {

  UserAccountsDrawerHeader _header() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Colors.teal,
      ),
      accountName: Text("Doutor"),
      accountEmail: Text("doutor@medical.com.br"),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage("assets/images/logo.png"),
        backgroundColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            _header(),
            ListTile(
              leading: Icon(Icons.language),
              title: Text("Idioma"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.vpn_key),
              title: Text("Alterar senha"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => {},
            )
          ],
        ),
      ),
    );  }
}
