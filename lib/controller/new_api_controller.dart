import 'dart:developer';

import 'package:chennai_machine_test/model/user_data.dart';
import 'package:chennai_machine_test/service/new_api_services.dart';

class NewApiControll {
  List<Result> allData = [];

  fetchdata() async {
    try {
      final response = await NewApiService().getdata();
      if (response!.statusCode == 200 || response.statusCode == 201) {
        final data = userDataFromJson(response.data);
      allData = data.results ;
        
        return data.results;
       
      }
    } catch (e) {
      log(e.toString());
    }
  }

 
 
}
