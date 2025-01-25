import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../models/pill_model.dart';

class HiveService {

  static var box = Hive.box('dorilar');

  static Future<void> init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive
      ..init(appDocumentDirectory.path)
      ..registerAdapter(PillAdapter());
    await Hive.openBox("dorilar");
  }

  static saveHiveService(PillModel pill) async{
    box.add(pill);
  }

  static updateHiveServiceId(int index, PillModel pill) async{
    box.putAt(index, pill);
  }

  static List<PillModel> fetchHiveService(){
    List<PillModel> pills = [];
    for (int i = 0; i < box.length; i++) {
      var card = box.getAt(i);
      pills.add(card);
    }
    return pills;
  }

  static deleteHiveServiceByIndex(int index) async {
    box.deleteAt(index);
  }

}