import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ThemeData _themeData;
  TextTheme get _textTheme => _themeData.textTheme;
  ColorScheme get _colorScheme => _themeData.colorScheme;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: Transform.scale(
          scale: 1.6,
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            child: Image.asset('assets/icon/Logo.png'),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Image.asset("assets/icon/Location.png"),
                Text(
                  "Nur-Sultan",
                  style: _textTheme.titleMedium?.copyWith(),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset("assets/icon/Language.png"),
                Text(
                  "Eng",
                  style: _textTheme.titleMedium?.copyWith(),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            width: 70,
            height: 40,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: _colorScheme.primary,
            ),
            child: Center(
              child: Text(
                "Log in",
                style: _textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upcoming",
                style: _textTheme.titleLarge?.copyWith(),
              ),
              const SizedBox(height: 27),
              CarouselSlider(
                options: CarouselOptions(
                  height: 380,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.7,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.accents[i % Colors.accents.length],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: _currentIndex,
                  count: 6,
                  effect: ExpandingDotsEffect(
                    dotWidth: 15,
                    dotHeight: 15,
                    activeDotColor: _colorScheme.primary,
                    dotColor: _colorScheme.primaryContainer,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Now in cinemas",
                    style: _textTheme.titleLarge?.copyWith(),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      size: 30,
                      color: _colorScheme.primaryContainer,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 9 / 16,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors
                                    .accents[index % Colors.accents.length],
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                width: 40,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: _colorScheme.primary,
                                ),
                                child: Center(
                                  child: Text(
                                    "9.1",
                                    style: _textTheme.bodyMedium?.copyWith(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Movie Title",
                        style: _textTheme.titleMedium?.copyWith(),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "Genre",
                        style: _textTheme.bodySmall?.copyWith(
                          color: _colorScheme.primaryContainer,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
