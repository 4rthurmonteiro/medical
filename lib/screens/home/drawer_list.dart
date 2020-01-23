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
        backgroundImage: AssetImage("assets/images/person.png"),
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
              leading: Icon(Icons.info),
              title: Text("Sobre"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => {},
            ),

          ],
        ),
      ),
    );  }
}
