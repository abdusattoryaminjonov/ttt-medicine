import 'package:TTTMedicine/models/pill_sql_model.dart';
import 'package:TTTMedicine/services/sql_service.dart';
import 'package:get/get.dart';

class PillsController extends GetxController{

  List<SqlPill> sqlPills = [];

  loadPills() async{
    var myPills = await SqlPillDatabase.getPills();
    sqlPills = myPills;
    update();
  }

  callAddPage(){
    Get.toNamed('add_page');
  }

}