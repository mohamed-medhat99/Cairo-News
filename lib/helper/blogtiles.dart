import 'package:advanced_news_app/views/article_view.dart';
import 'package:flutter/material.dart';
class BlogTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String describtion;
  final String url;

  const BlogTile({@required this.imgUrl, @required this.title, @required this.describtion,@required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=>ArticleView(
            blogUrl: url,
          ),
        ));
      },
          child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(imgUrl,
              ),
              ),
            Text(title,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 17,
            ),
            ),
            Text(describtion,
            maxLines: 4,
            style: TextStyle(
              color: Colors.black54,
            ),
            ),
          ],
        ),
      ),
    );
  }
}