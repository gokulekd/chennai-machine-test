import 'dart:developer';
import 'package:chennai_machine_test/model/company_model.dart';
import 'package:chennai_machine_test/service/api_service.dart';
import 'package:get/get.dart';

class ApiController extends GetxController {
  RxString newValueDropdown = "".obs;
    RxString newuserAssing = "".obs;


  List<CompanyModel> allCompanyList = [];
  fetchdata() async {
    try {
      final response = await ApiService().getdata();
      if (response!.statusCode == 200 || response.statusCode == 201) {
        final data = companyModelFromJson(response.data);
        allCompanyList = data;
        log("fetch sucess form api GetxController");
      }
      update();
    } catch (e) {
      log(e.toString());
    }
    update();
  }

  @override
  void onInit() {
    fetchdata();
    super.onInit();
  }

  void updateNewValue(String value) {
    newValueDropdown.value = value;
    update();
  }
    void newUserAssign(String value) {
    newuserAssing.value = value;
    update();
  }

}
