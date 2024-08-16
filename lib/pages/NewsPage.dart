import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:project_front_end/SocketMethods.dart';
import 'package:project_front_end/classes/models.dart';
import 'package:url_launcher/url_launcher.dart';

import 'HomePage.dart';

class NewsPage extends StatefulWidget {
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<NewsItem>? newsList = [
    NewsItem(imageUrl: 'https://quera.org/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fhero_image.46c9923a.png&w=1920&q=75',
        title: 'دوره‌های فشرده‌ی آماده‌سازی برنامه‌نویسان برای ورود به بازار کار',
        link: 'https://quera.org/bootcamp'),
      NewsItem(imageUrl: 'https://evand.com/_next/image?url=https%3A%2F%2Fstatic.evand.net%2Fimages%2Fevents%2Fcovers%2Foriginal%2F678a2457baea93cc26505acc7d6fdc28.png&w=1920&q=100',
          title: 'مسابقه برنامه‌نویسی Newbies 2024',
          link: 'https://evand.com/events/newbies2024'),
    NewsItem(imageUrl: 'https://quera.org/media/public/college/bootcamp/icons/742b7911b1504b2f8bfecfce7c875794..png',
        title: 'یادگیری مهارت‌های مدیریت محصول با تجربه‌ی پروژه‌های واقعی',
        link: 'https://quera.org/bootcamp/product-managment')
  ];


  @override
  Widget build(BuildContext context) {
    const darkBlue = Color.fromARGB(255, 78, 128, 152);
    const lightBlueBackground = Color.fromARGB(255, 206, 211, 220);
    const anotherBlue = Color.fromARGB(255, 34, 86, 111);
    const orangeBack = Color.fromARGB(255, 195, 144, 108);

    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: heightOfScreen,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.blueGrey.shade200,
                Colors.blueGrey.shade100,
                Colors.blueGrey.shade100,
                Colors.blueGrey.shade200,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: const [0.27, 0.5, 0.75, 0.97]),
          // color: lightBlueBackground,
        ),
        child: Stack(
          children: [
            Positioned(
              top: heightOfScreen * 0.08,
              right: (widthOfScreen - 245) / 2,
              width: widthOfScreen,
              child: const Text(
                  'خبرا رو دنبال کنید:',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'iransans',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: anotherBlue
                  )
              ),
            ),
            Positioned(
              top: 0.13 * heightOfScreen,
              child: SizedBox(
                height: 0.785 * heightOfScreen,
                width: widthOfScreen,
                child: ListView.builder(
                  itemCount: newsList?.length,
                  itemBuilder: (context, index) {
                    return NewsCard(
                      imageUrl: newsList![index].imageUrl,
                      title: newsList![index].title,
                      link: newsList![index].link,
                    );
                  },
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}

class NewsItem {
  final String imageUrl;
  final String title;
  final String link;

  NewsItem({required this.imageUrl, required this.title, required this.link});
}


class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String link;


  NewsCard({super.key, required this.imageUrl, required this.title, required this.link});

  @override
  Widget build(BuildContext context) {

  double widthOfScreen = MediaQuery.of(context).size.width;
  double heightOfScreen = MediaQuery.of(context).size.height;

    return Card(
      color : Colors.blueGrey.shade300,
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(imageUrl),
          Text(
            textDirection: TextDirection.rtl,
            title,
            style: const TextStyle(
                fontSize: 18,
                fontFamily: 'iransans',
                fontWeight: FontWeight.bold
            ),
          ),
          TextButton(
            child: const Text('ادامه مطلب',
                style: TextStyle(
                fontSize: 14,
                fontFamily: 'iransans',
                fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 34, 86, 111),
            ),),
            onPressed: () {
              // Use url_launcher package to open the link
              launchUrl(Uri.parse(link));
            },
          ),
        ],
      ),
    );
  }
}

/*class CourseCards extends StatelessWidget {
  String? courseName;
  String? courseId;
  String? courseUnit;
  Teacher? courseTeacher;

  CourseCards(this.courseName, this.courseId, this.courseUnit, this.courseTeacher, {super.key});

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;
    bool s = false;

    return Container(
      width: widthOfScreen,
      height: 0.2 * heightOfScreen,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color.fromARGB(102, 82, 131, 170),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        // mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: Container(
              width: 0.5 * widthOfScreen,
              height: 0.2 * heightOfScreen,
              // decoration: BoxDecoration(color: Colors.lightBlue.shade100),
              child: Column(
                textDirection: TextDirection.rtl,
                children: [
                  Flexible(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 2, right: 8),
                        alignment: Alignment.centerRight,
                        child: Text(
                          style: const TextStyle(
                            fontFamily: 'iransans',
                            fontSize: 24,
                            color: Color.fromARGB(255, 27, 68, 88),
                            fontWeight: FontWeight.w700,
                          ),
                          textDirection: TextDirection.rtl,
                          courseName!,
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(top: 2, bottom: 2, right: 8),
                        alignment: Alignment.centerRight,
                        child: Text(
                          style: const TextStyle(
                            fontFamily: 'iransans',
                            fontSize: 20,
                            color: Color.fromARGB(255, 27, 68, 88),
                            fontWeight: FontWeight.w200,
                          ),
                          textDirection: TextDirection.ltr,
                          courseId!,
                        ),
                      )),
                  Flexible(flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 2, bottom: 2, right: 8),
                        alignment: Alignment.topRight,
                        child: Text(
                          style: const TextStyle(
                            fontFamily: 'iransans',
                            fontSize:  18,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          textDirection: TextDirection.rtl,
                          '${courseUnit!} واحد',
                        ),
                      )
                  ),
                  Flexible(flex: 1, child: Container(
                    margin: const EdgeInsets.only(top: 2, right: 8, bottom: 5),
                    alignment: Alignment.topRight,
                    child: const Text(
                      style: TextStyle(
                        fontFamily: 'iransans',
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                      textDirection: TextDirection.rtl,
                      'امتحان: شنبه ۹ تیر',
                    ),
                  )),
                ],
              ),
            ),
          ),
          Flexible(
            child: Container(
              width: 0.5 * widthOfScreen,
              height: 0.2 * heightOfScreen,
              // decoration: BoxDecoration(color: Colors.lightBlue.shade100),
              child: Column(
                textDirection: TextDirection.rtl,
                children: [
                  Flexible(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 2, right: 15),
                        alignment: Alignment.centerRight,
                        child: Text(
                          style: const TextStyle(
                            fontFamily: 'iransans',
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          textDirection: TextDirection.ltr,
                          courseTeacher!.name,
                        ),
                      )),
                  Flexible(
                      flex: 7,
                      child: Container(
                        margin: const EdgeInsets.only(top: 2, bottom: 2, right: 15),
                        alignment: Alignment.centerRight,
                        child: const Text(
                          style: TextStyle(
                            fontFamily: 'iransans',
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w200,
                          ),
                          textDirection: TextDirection.rtl,
                          'ساعت کلاس:\n'
                              'شنبه ۱:۳۰ تا ۳:۰۰\n'
                              'دوشنبه ۱:۳۰ تا ۳:۰۰',
                        ),
                      )),
                ],
              ),
            ),
          ),
          *//* Text(
              todoStatement,
              style: const TextStyle(fontFamily: 'iransans')
          )*//*
        ],
      ),
    );
  }
}*/

