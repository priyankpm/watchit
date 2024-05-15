import 'package:watchit/Api/base_service.dart';
import 'package:watchit/Model/response_model.dart';
import 'package:watchit/View/Constant/api_urls.dart';

class HomeRepository {

  /// =====================Movie LIST REPO=================================///

  static Future<ResponseItem> categoryList() async {
    ResponseItem result;
    String requestUrl = ApiUrls.baseUrl;
    result = await BaseApiHelper.getRequest(requestUrl: requestUrl);
    return result;
  }

}