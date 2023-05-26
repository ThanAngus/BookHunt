import 'package:book_hunt/utils/components/shimmerComponent.dart';
import 'package:book_hunt/utils/responsiveLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScreen: Column(
        children: [
          ShimmerComponent(
            child: SizedBox(
              width: ScreenUtil().screenWidth / 3.5,
              height: 162,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ShimmerComponent(
            child: SizedBox(
              width: ScreenUtil().screenWidth / 3.5,
              height: 20,
            ),
          ),
          ShimmerComponent(
            child: SizedBox(
              width: ScreenUtil().screenWidth / 3.5,
              height: 20,
            ),
          ),
        ],
      ),
      webScreen: Column(
        children: [
          ShimmerComponent(
            child: SizedBox(
              height: 200,
              width: ScreenUtil().screenWidth * 0.08,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ShimmerComponent(
            child: SizedBox(
              width: ScreenUtil().screenWidth * 0.08,
              height: 20,
            ),
          ),
          ShimmerComponent(
            child: SizedBox(
              width: ScreenUtil().screenWidth * 0.08,
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> loadingList = List.generate(
  12,
  (index) => const LoadingCard(),
);
