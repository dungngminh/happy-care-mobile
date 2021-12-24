import 'dart:convert';

import 'package:happy_care/data/api/drug_api.dart';
import 'package:happy_care/data/models/drug.dart';

class DrugRepository {
  final DrugApi? drugApi;

  DrugRepository({this.drugApi});

  Future<List<Drug>> getAllDrug() async {
    String response = await drugApi!.getAllDrug();
    var converted = jsonDecode(response);
    Iterable list = converted['data']['drugs'];
    return list.map((data) => Drug.fromJson(data)).toList();
  }
}
