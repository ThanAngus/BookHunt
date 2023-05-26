import 'package:book_hunt/models/categoryTiles.dart';
import 'package:book_hunt/page/contentPage.dart';
import 'package:book_hunt/utils/colors.dart';
import 'package:book_hunt/utils/responsiveLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GenreTiles extends StatelessWidget {
  final GenreModel model;

  const GenreTiles({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ContentPage(
              model: model,
            ),
          ),
        );
      },
      child: ResponsiveLayout(
        mobileScreen: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppColors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(211, 209, 238, 0.5),
                  offset: Offset(0, 2),
                  blurRadius: 5,
                  spreadRadius: 0,
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: SvgPicture.asset(
                      model.icon,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    model.title.toUpperCase(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontFamily: 'Brand-Bold',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
                width: 25,
                child: SvgPicture.asset(
                  "assets/images/Next.svg",
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        webScreen: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 15,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppColors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(211, 209, 238, 0.5),
                  offset: Offset(0, 2),
                  blurRadius: 5,
                  spreadRadius: 0,
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: SvgPicture.asset(
                      model.icon,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    model.title.toUpperCase(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontFamily: 'Brand-Bold',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
                width: 25,
                child: SvgPicture.asset(
                  "assets/images/Next.svg",
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
