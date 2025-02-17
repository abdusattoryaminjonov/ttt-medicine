import 'package:TTTMedicine/services/chat_data.dart';

class RootService{
  static Future<void> init() async{
    await Future.wait([
      ChatNoSqlService.init(),
    ]);

  }
}