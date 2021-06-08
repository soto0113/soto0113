import 'package:firebase_helpers/firebase_helpers.dart';

class EventModel extends DatabaseItem{
  final String id;
  final String title;
  final String description;
  final String costo;
  final DateTime eventDate;

  EventModel({this.id,this.title, this.description, this.costo, this.eventDate}):super(id);

  factory EventModel.fromMap(Map data) {
    return EventModel(
      title: data['titulo'],
      description: data['descripcion'],
      costo: data['costo'],
      eventDate: data['fecha_actividad'],
    );
  }

  factory EventModel.fromDS(String id, Map<String,dynamic> data) {
    return EventModel(
      id: id,
      title: data['titulo'],
      description: data['descripcion'],
      costo: data['costo'],
      eventDate: data['fecha_actividad'].toDate(),
    );
  }

  Map<String,dynamic> toMap() {
    return {
      "titulo":title,
      "descripcion": description,
      "costo": costo,
      "fecha_actividad":eventDate,
      //"id":id,
    };
  }
}