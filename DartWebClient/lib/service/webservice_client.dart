library webservice_client;

import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'package:transpori/model/model.dart';
import 'package:transpori/model/station/station.dart';
import 'package:transpori/model/transportation_line/transportation_line.dart';

part 'w_s_transportation_line.dart';
part 'w_s_station.dart';
part 'w_s_station_suggestion.dart';
part 'w_s_transportation_request.dart';
part 'w_s_user.dart';

class WebserviceClient {

  //final String rawWebServiceUrl = "http://tmorocco-mdeveloper.rhcloud.com/rest/";
  final String rawWebServiceUrl = "http://localhost:8081/rest/";
  final String httpPut = "PUT";
  final String httpGet = "GET";
  final String httpPost = "POST";
  final String httpDelete = "DELETE";
  final Map rawRequestHeader = {
    "content-type": "application/json"
  };
  final User user;

  WebserviceClient(this.user);

  Map get requestHeader {
    if (user != null && user.id != null) rawRequestHeader["authorization"] = user.authorizationString;
    return rawRequestHeader;
  }
}
