import 'package:firebase_helpers/firebase_helpers.dart';
import 'activity.dart';

DatabaseService<EventModel> eventDBS = DatabaseService<EventModel>("actividades",fromDS: (id,data) => EventModel.fromDS(id, data), toMap:(event) => event.toMap());
