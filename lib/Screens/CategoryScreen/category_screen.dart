import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/category_mode.dart';
import 'package:news_app/view_model/news_view_model.dart';

import '../HomeScreen/news_detail.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd, yyyy');

  String categoryName = 'General';

  List<String> btnCateogories = [
    'General',
    'Entertaintment',
    'Health',
    'Sports',
    'Business',
    'Technology',
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      categoryName = btnCateogories[index];
                      setState(() {});
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: categoryName == btnCateogories[index]
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Center(
                            child: Text(
                              btnCateogories[index].toString(),
                              style: TextStyle(
                                color: categoryName == btnCateogories[index]
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: btnCateogories.length,
              ),
            ),
            Expanded(
              child: FutureBuilder<CategoryModel>(
                  future: newsViewModel.fetchNewsCategoriesApi(categoryName),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Colors.blue,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetailScreen(
                                  img: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  title: snapshot
                                      .data!.articles![index].title
                                      .toString(),
                                  newsdate:  format.format(dateTime),
                                  author: snapshot
                                      .data!.articles![index].author
                                      .toString(),
                                  description: snapshot
                                      .data!.articles![index].description
                                      .toString(),
                                  content: snapshot
                                      .data!.articles![index].content
                                      .toString(),
                                  source: snapshot
                                      .data!.articles![index].source!.name
                                      .toString(),

                                ),
                              ),
                            );
                          },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      height: height * .18,
                                      width: width * .3,
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        child: SpinKitCircle(
                                          color: Colors.blue,
                                          size: 50,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                          ),
                                    ),
                                  ),
                                  Expanded(child: Container(
                                    height: height * .18,
                                    padding: EdgeInsets.only(left: 15),
                                 child: Column(
                                   children: [
                                     Text(
                                       snapshot
                                           .data!.articles![index].title
                                           .toString(),
                                       maxLines: 2,
                                       overflow: TextOverflow.ellipsis,
                                       style: GoogleFonts.poppins(
                                         fontSize: 13,
                                         color: Colors.black,
                                         fontWeight: FontWeight.w700,
                                       ),
                                     ),
                                     Spacer(),
                                     Row(
                                       mainAxisAlignment:
                                       MainAxisAlignment
                                           .spaceBetween,
                                       children: [
                                         Text(
                                           snapshot
                                               .data!
                                               .articles![index]
                                               .source!
                                               .name
                                               .toString(),
                                           style: GoogleFonts.poppins(
                                             fontSize: 10,
                                             fontWeight: FontWeight.w600,
                                           ),
                                         ),
                                         Text(
                                           format.format(dateTime),
                                           style: GoogleFonts.poppins(
                                             fontSize: 10,
                                             fontWeight: FontWeight.w500,
                                           ),
                                         ),
                                       ],
                                     ),
                                   ],
                                 ),
                                  ),

                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: snapshot.data!.articles!.length,
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
