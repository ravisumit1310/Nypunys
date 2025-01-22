import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';


class RequestMethods{
  String post = 'POST';
  String get = 'GET';
}

class Connect{
  GetStorage? box;
  String? url;
  Map<String, String> headers = {};
  Connect(this.box){
    url = Routes.baseUrl;
  }
  Future<HttpResponseModel<dynamic>?> getReq({url}) async{
    log("getting data");

    try {

      String? host,sessionId;
      if(box!.hasData(LocalStorageKeys.sessionId.name)){
        sessionId = box!.read(LocalStorageKeys.sessionId.name);
      }
      if(sessionId != null){
        headers['cookie'] = sessionId;
      }
      print(headers);

      host = url;


      // String host = "${Routes.baseUrl}/${body['event']}/";
      log(host.toString());
      var response = await get(Uri.parse(host!),headers: headers);
      print("----res");
      print(response.body);

      if(response.statusCode == 200){
        var json = jsonDecode(response.body);
        print("response succes");
        String? message = "";
        message = json['message'];
        if(json['status'] == 'success'){
          String? rawCookie = response.headers['set-cookie'];
          print(rawCookie);
          if (rawCookie != null) {
            int index = rawCookie.indexOf(';');
            sessionId = (index == -1) ? rawCookie : rawCookie.substring(0, index);
            print(sessionId);
            print("saving session");
            box!.write(LocalStorageKeys.sessionId.name, sessionId);

          }
          return HttpResponseModel(true,json['data'],message: message,responseCode:response.statusCode);
        }else{
          print("error");
          //handle error with
          return HttpResponseModel(false,json['message'],message: message,responseCode: response.statusCode);
        }
      }else{
        print("response failed....");
        //   response failed
      }

    }catch(e){
      print(e.toString());
      return null;
    }


  }

  Future<HttpResponseModel<dynamic>?> postReq({body, url}) async{
    log("posting data");
    try {
      String? host,sessionId;
      if(box!.hasData(LocalStorageKeys.sessionId.name)){
        sessionId = box!.read(LocalStorageKeys.sessionId.name);
      }
      if(sessionId != null){
        headers['cookie'] = sessionId;
      }

      host = "${url}";

      print(headers);
      var response = await post(Uri.parse(host), body: jsonEncode(body),headers: headers);
      print(response.body);

      if(response.statusCode == 200){
        var json = jsonDecode(response.body);
        print("response succes");
        String? message = "";
        message = json['message'];
        if(json['status'] == 'success'){
          String? rawCookie = response.headers['set-cookie'];
          print("cookie=-=--");

          print(rawCookie);
          if (rawCookie != null) {
            int index = rawCookie.indexOf(';');
            sessionId = (index == -1) ? rawCookie : rawCookie.substring(0, index);
            print(sessionId);
            print("saving session");
            box!.write(LocalStorageKeys.sessionId.name, sessionId);

          }
          return HttpResponseModel(true,json['data'],message: message,responseCode:json['code']);
        }else{
          //handle error with
          return HttpResponseModel(false,json,message: message,responseCode: json['code']);
        }
      }else{
        print("response failed....");
        return HttpResponseModel(false,json,message: "Sorry something happened !",responseCode: null);
        //   response failed
      }

    }catch(e){
      print(e.toString());
      return HttpResponseModel(false,json,message: e.toString(),responseCode: null);
    }


  }



}

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl =
      "https://d067-2401-4900-1f26-2dec-9438-e70d-c3b3-422a.ngrok-free.app";
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  Future<dynamic> get(String endpoint) async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl$endpoint'), headers: _headers);
      return _handleResponse(response);
    } catch (e) {
      print("GET request error: $e");
      return null;
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl$endpoint'),
        headers: _headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      print("POST request error: $e");
      return null;
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      print("API error: ${response.statusCode} ${response.body}");
      return null;
    }
  }
}
