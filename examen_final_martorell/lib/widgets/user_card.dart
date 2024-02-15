import '../models/models.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final Abre abre;
  const UserCard({super.key, required this.abre});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text(abre.nom)),
      title: Text(abre.nom),
      subtitle: Text(
        "${abre.varietat}",
        style: TextStyle(color: Colors.black.withOpacity(0.6)),
      ));
  }
}
