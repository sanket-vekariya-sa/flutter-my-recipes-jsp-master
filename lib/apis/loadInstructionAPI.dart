
import 'dart:io';

import 'package:Flavr/model/InstructionDetailsFeed.dart';
import 'package:dio/dio.dart';

class LoadingInstructionAPI{
  var _instructionDetails;

   Future<List<InstructionDetailsFeed>> loadInstruction(int list) async {
    String instructionsURL =
        "http://35.160.197.175:3006/api/v1/recipe/${list}/instructions";
    var dio = new Dio();
    Map<String, dynamic> map = {
      HttpHeaders.authorizationHeader:
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6Mn0.MGBf-reNrHdQuwQzRDDNPMo5oWv4GlZKlDShFAAe16s"
    };
    var response1 =
    await dio.get(instructionsURL, options: Options(headers: map));

    for (var memberJSON in response1.data) {
      final instructionfeed = new InstructionDetailsFeed(
        memberJSON["id"],
        memberJSON["instruction"],
      );
      _instructionDetails.add(instructionfeed);
    }
    return _instructionDetails;
  }
}

