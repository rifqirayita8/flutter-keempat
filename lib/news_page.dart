import 'package:flutter/material.dart';
import 'package:news_app/client.dart';
import 'package:news_app/response_articles.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  late List<Article> listArticle;
  bool isLoading= false;

  Future getListArticle() async{
    setState(() {
      isLoading= true;
    });

    listArticle= await Client.fetchArticle();
    print(listArticle);

    setState(() {
      isLoading= false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
      ? const Center(
        child: CircularProgressIndicator(),
      )
    : listArticle.isEmpty
      ?const Text("Tidak ada data")
      : ListView.builder(
        itemCount: listArticle.length,
        itemBuilder: (context, index){
          final article= listArticle[index];
          return GestureDetector(
            child: Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
                elevation: 5,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Image.network(
                        article.urlToImage,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        ),
                    )
                  ],
                ),
            ),
          );
        }
        )
    );
  }
}