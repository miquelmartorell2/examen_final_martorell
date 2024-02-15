import 'package:examen_final_martorell/models/abre.dart';
import 'package:examen_final_martorell/preferences/preferences.dart';
import 'package:examen_final_martorell/services/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../ui/ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final userService = Provider.of<UserService>(context);
    List<Abre> usuaris = userService.users;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () {
              Preferences.clear();
              Navigator.pop(context, {'clearText': true, 'username': '', 'password': ''});
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: usuaris.isEmpty
          ? Loading()
          : ListView.builder(
              itemCount: usuaris.length,
              itemBuilder: ((context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  child: GestureDetector(
                    child: UserCard(abre: usuaris[index]),
                    onTap: () {
                      userService.tempUser = usuaris[index].copy();
                      Navigator.of(context).pushNamed('detail');
                    },
                  ),
                  onDismissed: (direction) {
                    if (usuaris.length < 2) {
                      userService.loadUsers();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('No es pot esborrar tots els elements!')));
                    } else {
                      userService.deleteUser(usuaris[index]);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              '${userService.users[index].nom} esborrat')));
                    }
                  },
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          userService.tempUser = Abre(nom: '',varietat: '', tipus: '', autocton: false, foto: '', detall: '' );
          Navigator.of(context).pushNamed('detail');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
