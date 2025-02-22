import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/pages/article_view.dart';

class BlogTile extends StatefulWidget {
  String imageUrl, title, desc, url;
  BlogTile({
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.url,
  });

  @override
  State<BlogTile> createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(blogUrl: widget.url)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: Text(
                            widget.title,
                            maxLines: 2,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 17.0),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.7,
                          child: Text(
                            widget.desc,
                            maxLines: 3,
                            style: const TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
