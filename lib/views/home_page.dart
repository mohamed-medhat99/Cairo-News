import 'package:advanced_news_app/helper/blogtiles.dart';
import 'package:advanced_news_app/helper/data.dart';
import 'package:advanced_news_app/model/article_model.dart';
import 'package:advanced_news_app/model/category_model.dart';
import 'package:advanced_news_app/views/article_view.dart';
import 'package:advanced_news_app/views/category_news.dart';
import 'package:flutter/material.dart';
import '../helper/news.dart';
import '../main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  Future<Welcome> _newsModel;
  List<CategoryModel> categories = new List<CategoryModel>(); 
  @override
  void initState (){
    categories = getCategories();
    _newsModel = API_Manager().getNews();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Cairo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 27
            ),
            ),
            Text('News',
            style: TextStyle(
              color: Colors.blue,
            ),
            ),
            Icon(
              Icons.landscape,
            ),
          ],
        ),
      ),
      //categories
      body: RefreshIndicator(
        onRefresh: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (a, b, c) => MyApp(),
              transitionDuration: Duration(seconds: 0),
            ),
          );
          return Future.value(false);
        },
              child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    children: <Widget>[
                      Container(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          shrinkWrap: true,               
                          itemBuilder: (context , index){
                            return CategoryCards(
                              title: categories[index].categoryName,
                              imageUrl: categories[index].imageUrl,
                            );
                          }
                          ),
                      ),
                      //end of categories
                      Container(
                        padding: EdgeInsets.only(top: 16),
                        child: FutureBuilder<Welcome>(
                          future: _newsModel,
                          builder: (context , snapshot){
                            if (snapshot.hasData){
                              return ListView.builder(
                                physics:  ClampingScrollPhysics(),
                                shrinkWrap: true,
                            itemCount: snapshot.data.articles.length,
                            itemBuilder: (context , index){
                              var article = snapshot.data.articles[index];
                              return BlogTile(
                                url: article.url,
                                imgUrl: article.urlToImage == null
                                    ? ''
                                    : article.urlToImage,
                                title: article.title,
                                describtion: article.description == null
                                    ? 'No Description provided from the author'
                                    : article.description,
                              );
                            }
                            );
                            }else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                    ],
                  ),
              ),
          ),
      ),
    );
  }
}
class CategoryCards extends StatelessWidget {
  final String imageUrl;
  final String title;
  CategoryCards({this.imageUrl , this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=> CategoryNews(
            category: title,
          ),
        ));
      },
          child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(11),
                        child: Image.network(imageUrl ,width: 120 , height: 60,
              fit: BoxFit.cover,
              ),
            ),
             Container(
               width: 120,
               height: 60,
               alignment: Alignment.center,
               child: Text(
                 title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                ),
             ),
          ],
        ),
      ),
    );
  }
}

