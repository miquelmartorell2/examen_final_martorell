import 'package:examen_final_martorell/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ui/input_decorations.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userForm = Provider.of<UserService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: _UserForm(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (userForm.isValidForm()) {
            userForm.saveOrCreateUser();
            Navigator.of(context).pop();
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}


class _UserForm extends StatefulWidget {
  @override
  __UserFormState createState() => __UserFormState();
}

class __UserFormState extends State<_UserForm> {
  @override
  Widget build(BuildContext context) {
    final userForm = Provider.of<UserService>(context);
    final tempUser = userForm.tempUser;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: _buildBoxDecoration(),
      child: Form(
        key: userForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            SizedBox(height: 10),
            TextFormField(
              initialValue: tempUser.nom,
              onChanged: (value) => setState(() => tempUser.nom = value),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'El nom és obligatori';
                return null;
              },
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Nom',
                labelText: 'Nom:',
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              initialValue: tempUser.varietat,
              onChanged: (value) => setState(() => tempUser.varietat = value),
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Varietat',
                labelText: 'Varietat:',
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              initialValue: tempUser.tipus,
              onChanged: (value) => setState(() => tempUser.tipus = value),
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Tipus',
                labelText: 'Tipus:',
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text('Autocton:'),
                SizedBox(width: 10),
                Switch(
                  value: tempUser.autocton,
                  onChanged: (value) {
                    setState(() {
                      tempUser.autocton = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            TextFormField(
              initialValue: tempUser.foto,
              onChanged: (value) => setState(() => tempUser.foto = value),
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Foto',
                labelText: 'Foto:',
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              initialValue: tempUser.detall,
              onChanged: (value) => setState(() => tempUser.detall = value),
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Detall',
                labelText: 'Detall:',
              ),
            ),
            SizedBox(height: 30),
            Visibility(
              visible: tempUser.foto.isNotEmpty,
              child: Image.network(tempUser.foto),
            ),
            SizedBox(height: 30),
            Visibility(
              visible: tempUser.detall.isNotEmpty,
              child: ElevatedButton(
                onPressed: () {
                  launch(tempUser.detall);
                },
                child: Text('Detall'),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }



  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 5),
              blurRadius: 5),
        ],
      );
}
