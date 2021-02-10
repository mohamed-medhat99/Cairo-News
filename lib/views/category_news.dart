import 'package:advanced_news_app/helper/blogtiles.dart';
import 'package:advanced_news_app/helper/data.dart';
import 'package:advanced_news_app/helper/news.dart';
import 'package:advanced_news_app/model/article_model.dart';
import 'package:advanced_news_app/model/category_model.dart';
import 'package:flutter/material.dart';

class CategoryNews extends StatefulWidget {
  final String category;

  const CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  Future<Welcome> _newsModel;
  List<CategoryModel> categories = new List<CategoryModel>();
  @override
  void initState() {
    categories = getCategories();
    _newsModel = CategoryAPI_Manager().getCategoryNews(widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Cairo',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
            ),
            Text(
              'News',
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 16),
                child: FutureBuilder<Welcome>(
                  future: _newsModel,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.articles.length,
                          itemBuilder: (context, index) {
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
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
