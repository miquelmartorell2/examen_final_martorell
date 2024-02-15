import 'dart:convert';
import '../models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserService extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String _baseUrl =
      "examen-final-martorell-default-rtdb.europe-west1.firebasedatabase.app";
  List<Abre> users = [];
  late Abre tempUser;
  Abre? newUser;

  UserService() {
    this.loadUsers();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }


  loadUsers() async {
    print('object');
    users.clear();
    final url = Uri.https(_baseUrl, 'Abres.json');
    print(url);
    
    final response = await http.get(url);
    print(json.decode(response.body));
    final Map<String, dynamic> usersMap = json.decode(response.body);

    // Mapejam la resposta del servidor, per cada usuari, el convertim a la classe i l'afegim a la llista
    usersMap.forEach((key, value) {
      final auxUser = Abre.fromMap(value);
      auxUser.id = key;
      users.add(auxUser);
    });

    notifyListeners();
  }

  Future saveOrCreateUser() async {
    if (tempUser.id == null) {
      //Cream l'usuari
      await this.createUser();
    } else {
      //Actualitzam l'usuari
      await this.updateUser();
    }
    loadUsers();
  }

  updateUser() async {

    final url = Uri.https(_baseUrl, 'Abres/${tempUser.id}.json');
    print(url);
    final response = await http.put(url, body: tempUser.toJson());
    final decodedData = response.body;
  }

  createUser() async {
    final url = Uri.https(_baseUrl, 'Abres.json');
    final response = await http.post(url, body: tempUser.toJson());
    final decodedData = json.decode(response.body);
  }

  deleteUser(Abre usuari) async {
    print(usuari.id);
    print('test');
    final url = Uri.https(_baseUrl, 'Abres/${usuari.id}.json');
    final response = await http.delete(url);
    final decodedData = json.decode(response.body);
    print(decodedData);
    loadUsers();
  }
}
