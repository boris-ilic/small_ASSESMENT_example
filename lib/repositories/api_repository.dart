import 'package:dio/dio.dart';
import 'package:maka_assessment/constants/environment_constants.dart';
import 'package:maka_assessment/models/inventory_model.dart';
import 'package:maka_assessment/models/show_item_model.dart';

class ApiRepository {
  ApiRepository();
  final Dio _dio = Dio();

  /// save items api
  Future<void> saveItems(List<InventoryModel> items) async {
    List<Map<String, dynamic>> itemsMap = items.map((item) => item.toJson()).toList();
    await _dio.post("${Env.baseUrl}/inventory", data: itemsMap);
  }

  /// get all items for provided show Id
  Future<List<ShowItemModel>> getShowItems(int showId) async {
    var response =
        await _dio.get("${Env.baseUrl}/show/$showId"); //TODO add one w to show to test error case
    final List<dynamic> data = response.data;

    return data.map((item) => ShowItemModel.fromJson(item)).toList();
  }

  /// api for buying items
  Future<int> buyItem(int showId, int itemId) async {
    var response = await _dio.post("${Env.baseUrl}/show/$showId/buy_item/$itemId");
    return response.statusCode ?? 0;
  }
}
