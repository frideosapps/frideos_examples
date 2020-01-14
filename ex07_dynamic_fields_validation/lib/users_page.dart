import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  UsersPage({this.users});

  final Map users;

  @override
  Widget build(BuildContext context) {
    List<Widget> _buildUsers() {
      return List<Widget>.generate(
        users.length,
        (i) => Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('User: ',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    Text('${i + 1}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Name: ',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    Text(users[i]['name']),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Age: ',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    Text(users[i]['age']),
                  ],
                ),
                Divider(),
              ],
            ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Users info'),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 12),
          child: ListView(
            children: _buildUsers(),
          ),
        ),
      ),
    );
  }
}
