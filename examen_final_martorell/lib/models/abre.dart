import 'dart:convert';

class Abre {
  Abre({
    this.id,
    required this.nom,
    required this.varietat,
    required this.tipus,
    required this.autocton,
    required this.foto,
    required this.detall
  });
  String? id;
  String nom;
  String varietat;
  String tipus;
  bool autocton;
  String foto;
  String detall;

  factory Abre.fromJson(String str) => Abre.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Abre.fromMap(Map<String, dynamic> json) => Abre(
        nom: json["nom"],
        varietat: json["varietat"],
        tipus: json["tipus"],
        autocton: json["autocton"],
        foto: json["foto"],
        detall: json["detall"]
      );

  Map<String, dynamic> toMap() => {
        "nom": nom,
        "varietat": varietat,
        "tipus": tipus,
        "autocton": autocton,
        "foto": foto,
        "detall": detall
      };

  Abre copy() => Abre(nom: nom, varietat: varietat, tipus: tipus, autocton: autocton, foto: foto, detall: detall, id: id);
}
