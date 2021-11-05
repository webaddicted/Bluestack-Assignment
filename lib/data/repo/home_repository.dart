import 'dart:convert';

import 'package:tournament/data/bean/home_respo.dart';
import 'package:tournament/data/repo/base_repo.dart';
import 'package:tournament/utils/apiutils/api_base_helper.dart';
import 'package:tournament/utils/apiutils/api_response.dart';
import 'package:tournament/utils/constant/api_constant.dart';

class HomeRepository extends BaseRepo {
 getTournament({int pageNo = 1}) async {
    var map = <String, String>{};
    map['limit'] = (pageNo * 10).toString();
    map['status'] = 'all';
    final response =
        await apiHelper.get(url: ApiConstant.tournamentsListV2, params: map);

    return ApiResponse.returnResponse(
        response,
        response.data == null
            ? null
            : HomeRespo.fromJson(jsonDecode(response.toString())));
  }
}
