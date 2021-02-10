import 'dart:convert';

import '../model/article_model.dart';
import 'package:http/http.dart' as http;
class API_Manager {
  String url = 'http://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=0a40587a9b78488c897a9218c7726fc6';
  Future<Welcome> getNews() async {
  var client = http.Client();
  var newsModel;
  try{  
  var response = await  client.get(url);
  if (response.statusCode == 200 ){
    var jsonString = response.body;
    var jsonMap = jsonDecode(jsonString);
     newsModel = Welcome.fromJson(jsonMap);
  }
  }
  catch(Exception)
  {
    return newsModel;
  }
  return newsModel;
  }
}
class CategoryAPI_Manager {
  Future<Welcome> getCategoryNews(String category) async {
    String url = 'http://newsapi.org/v2/top-headlines?country=eg&category=$category&business&apiKey=0a40587a9b78488c897a9218c7726fc6';
  var client = http.Client();
  var newsModel;
  try{  
  var response = await  client.get(url);
  if (response.statusCode == 200 ){
    var jsonString = response.body;
    var jsonMap = jsonDecode(jsonString);
     newsModel = Welcome.fromJson(jsonMap);
  }
  }
  catch(Exception)
  {
    return newsModel;
  }
  return newsModel;
  }
}
