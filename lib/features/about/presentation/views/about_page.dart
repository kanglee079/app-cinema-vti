import 'package:flutter/material.dart';

import '../../../../widgets/item_tile_about_page.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late ThemeData _themeData;
  TextTheme get _textTheme => _themeData.textTheme;
  ColorScheme get _colorScheme => _themeData.colorScheme;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            padding: const EdgeInsets.only(left: 15),
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios,
              color: _themeData.colorScheme.primaryContainer,
            ),
          ),
          title: Text(
            'The Batman',
            style: _textTheme.titleLarge,
          ),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: _themeData.colorScheme.primaryContainer,
            labelStyle: _textTheme.titleMedium,
            labelColor: _colorScheme.primary,
            tabs: const [
              Tab(
                text: 'About',
              ),
              Tab(
                text: 'Sessions',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AboutTab(),
            SessionsTab(),
          ],
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 110,
          decoration: BoxDecoration(
            color: _colorScheme.surface,
          ),
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(21),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "Select session",
                    style: _textTheme.titleMedium!.copyWith(
                      color: _colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AboutTab extends StatefulWidget {
  const AboutTab({super.key});

  @override
  State<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> {
  late ThemeData _themeData;
  TextTheme get _textTheme => _themeData.textTheme;
  ColorScheme get _colorScheme => _themeData.colorScheme;
  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.white70,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 85,
                  color: _colorScheme.surface,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "8.3",
                        style: _textTheme.titleLarge,
                      ),
                      Text(
                        "IMDB",
                        style: _textTheme.bodyMedium?.copyWith(
                          color: _colorScheme.primaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(width: 1, height: 90, color: Colors.white12),
              Expanded(
                child: Container(
                  height: 85,
                  color: _colorScheme.surface,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "7.9",
                        style: _textTheme.titleLarge,
                      ),
                      Text(
                        "Kinopoisk",
                        style: _textTheme.bodyMedium?.copyWith(
                          color: _colorScheme.primaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  "When the Riddler, a sadistic serial killer, begins murdering key political figures in Gotham, Batman is forced to investigate the city's hidden corruption and question his family's involvement.",
                  style: _textTheme.bodyMedium,
                ),
                const SizedBox(height: 15),
                ItemTileAboutPage(
                  textTheme: _textTheme,
                  colorScheme: _colorScheme,
                  title: 'Certificate',
                  content: '16+',
                ),
                ItemTileAboutPage(
                  textTheme: _textTheme,
                  colorScheme: _colorScheme,
                  title: 'Runtime',
                  content: '02:56',
                ),
                ItemTileAboutPage(
                  textTheme: _textTheme,
                  colorScheme: _colorScheme,
                  title: 'Release',
                  content: '2022',
                ),
                ItemTileAboutPage(
                  textTheme: _textTheme,
                  colorScheme: _colorScheme,
                  title: 'Genre',
                  content: 'Action, Crime, Drama, Animation, Comedy',
                ),
                ItemTileAboutPage(
                  textTheme: _textTheme,
                  colorScheme: _colorScheme,
                  title: 'Director',
                  content: 'Matt Reeves',
                ),
                ItemTileAboutPage(
                  textTheme: _textTheme,
                  colorScheme: _colorScheme,
                  title: 'Cast',
                  content:
                      'Robert Pattinson, Zoë Kravitz, Jeffrey Wright, Colin Farrell, Paul Dano, John Turturro, 	Andy Serkis, Peter Sarsgaard',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SessionsTab extends StatelessWidget {
  const SessionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Sessions content'),
    );
  }
}
