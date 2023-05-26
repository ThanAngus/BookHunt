import 'package:book_hunt/models/categoryTiles.dart';
import 'package:book_hunt/utils/colors.dart';
import 'package:book_hunt/utils/components/genreTiles.dart';
import 'package:book_hunt/utils/responsiveLayout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        webScreen: Stack(
          children: [
            Container(
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight / 4,
              color: AppColors.white,
              child: SvgPicture.asset(
                "assets/images/Pattern.svg",
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Container(
                        height: ScreenUtil().screenHeight / 4,
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          bottom: 60,
                          left: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Gutenberg Project",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(10),
                            ),
                            Text(
                              "A social cataloging website that allows you to freely search its database of books, annotations, and reviews.",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 6,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 40,
                        ),
                        itemBuilder: (context, index){
                          GenreModel genreModel = category[index];
                          return GenreTiles(
                            model: genreModel,
                          );
                        },
                        itemCount: category.length,
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
              ],
            ),
          ],
        ),
        mobileScreen: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: ScreenUtil().screenWidth,
                    height: ScreenUtil().screenHeight / 3,
                    color: AppColors.white,
                    child: SvgPicture.asset(
                      "assets/images/Pattern.svg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 60,
                      left: 30,
                      right: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gutenberg Project",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        Text(
                          "A social cataloging website that allows you to freely search its database of books, annotations, and reviews.",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    GenreModel genreModel = category[index];
                    return GenreTiles(
                      model: genreModel,
                    );
                  },
                  itemCount: category.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: ScreenUtil().setHeight(10),
                    );
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
