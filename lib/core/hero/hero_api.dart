import 'package:servicesplatform/network/dio_client.dart';

import 'hero_model.dart';

class HeroApi {
  Future<List<HeroModel>> fetchHeroes() async {
    final response = await DioClient.dio.get('api/hero/');

    final List list = response.data as List;
    return list.map((e) => HeroModel.fromJson(e)).toList();
  }
}
