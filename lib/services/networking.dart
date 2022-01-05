import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper{

  String url;
  NetworkHelper({this.url});
  var decodedData;

  Future getData() async{
    var uri = Uri.parse(url);
    var response = await http.get(uri);

    if(response.statusCode == 200){
      var data = response.body;
      decodedData  = jsonDecode(data);
    }
    else{
      print(response.statusCode);
    }
    return decodedData;
  }
}