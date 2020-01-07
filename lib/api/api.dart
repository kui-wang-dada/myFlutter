import '../utils/dio/data_helper.dart';
import '../utils/dio/http.dart';
import 'home.dart';

class Api {
  static String BASE_URL = "https://erp.wholerengroup.com/apis";

  ///示例请求
  static get(String api, {param}) {
    var params = DataHelper.getBaseMap();
    params['param'] = param;

    return HttpManager.getInstance().get(BASE_URL + api, params);
  }

  ///示例请求
  static post(String api, {param}) {
    var params = DataHelper.getBaseMap();
    params['param'] = param;
    return HttpManager.getInstance().post(BASE_URL + api, params);
  }
}
