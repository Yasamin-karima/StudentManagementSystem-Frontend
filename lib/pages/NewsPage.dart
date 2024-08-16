
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


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
    const blue = Color.fromARGB(255, 34, 86, 111);

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
                      color: blue
                  )
              ),
            ),//above text
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
            )//news list

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


  const NewsCard({super.key, required this.imageUrl, required this.title, required this.link});

  @override
  Widget build(BuildContext context) {

    return Card(
      color : Colors.blueGrey.shade300,
      margin: const EdgeInsets.all(8),
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
              launchUrl(Uri.parse(link));
            },
          ),
        ],
      ),
    );
  }
}


