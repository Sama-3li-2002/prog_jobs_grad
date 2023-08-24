import 'package:flutter/cupertino.dart';
import 'package:prog_jobs_grad/controller/FirebaseFireStoreHelper.dart';

import '../controller/FirebaseAuthController.dart';
import '../model/CompanyModel.dart';

class ComInfoProvider extends ChangeNotifier {
  List<Company> comInfoList = [];

  Future<List<Company>> getComInfoObjects() async {
    comInfoList = await FirebaseFireStoreHelper.instance
        .getComInfoById(FirebaseAuthController.fireAuthHelper.userId());
    notifyListeners();
    return comInfoList;
  }
}
