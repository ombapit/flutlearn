import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Controller extends GetxController {
  var count = 0.obs;
  increment() => count++;

  var us = [].obs;

  Future<void> getSkill() async {
    var url = Uri.https('mocki.io', 'v1/3b381c3a-e99d-47fe-a437-bf2a2ddf7b77');
    var response = await http.get(url);
    var list = jsonDecode(response.body);

    for (var data in list) {
      us.add({"name": data['listname'], "selected": false});
    }
  }

  @override
  // ignore: unnecessary_overrides
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getSkill();
  }
}
