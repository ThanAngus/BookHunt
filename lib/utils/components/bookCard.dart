import 'dart:io';
import 'package:book_hunt/models/bookModel.dart';
import 'package:book_hunt/utils/colors.dart';
import 'package:book_hunt/utils/components/loadingCard.dart';
import 'package:book_hunt/utils/responsiveLayout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class BookCard extends ConsumerWidget {
  final Results model;

  const BookCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  Future<void> launchLink(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.platformDefault,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> showContent(BuildContext context, Formats formats) async {
    if (formats.textHtml != null) {
      launchLink(formats.textHtml!);
    } else if (formats.applicationPdf != null) {
      launchLink(formats.applicationPdf!);
    } else if (formats.textPlain != null) {
      launchLink(formats.textPlain!);
    } /*else if(formats.applicationZip != null){
      List<String> extractedFiles = await extractZipFromUrl(formats.applicationZip!);
      for (String file in extractedFiles) {
        //show type of file content and display content
      }
    } */else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Center(
              child: Text(
                "Not available",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                textAlign: TextAlign.justify,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "There are no viewable version currently.",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            actions: [
              InkWell(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    child: Text(
                      "Okay",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  Future<List<String>> extractZipFromUrl(String zipUrl) async {
    try {
      final response = await http.get(Uri.parse(zipUrl));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final destinationDir = Directory.systemTemp;
        final zipFile = File('${destinationDir.path}/file.zip');
        await zipFile.writeAsBytes(bytes);
        await ZipFile.extractToDirectory(
          zipFile: zipFile,
          destinationDir: destinationDir,
        );

        final extractedFiles = Directory(destinationDir.path).listSync(recursive: true)
            .whereType<File>()
            .map((entity) => entity.path)
            .toList();

        return extractedFiles;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        showContent(
          context,
          model.formats!,
        );
      },
      child: ResponsiveLayout(
        mobileScreen: SizedBox(
          width: ScreenUtil().screenWidth / 3.5,
          child: CachedNetworkImage(
            imageUrl: model.formats!.imageJpeg!,
            imageBuilder: (context, imageProvider) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: ScreenUtil().screenWidth / 3.5,
                  height: 162,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(211, 209, 238, 0.5),
                        offset: Offset(0, 2),
                        blurRadius: 5,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
                Text(
                  model.title.toUpperCase(),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  model.authors!.isNotEmpty ? model.authors![0].name! : "",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            errorWidget: (context, url, error) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 114,
                  height: 162,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColors.grey,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(211, 209, 238, 0.5),
                        offset: Offset(0, 2),
                        blurRadius: 5,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      model.title[0],
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                ),
                Text(
                  model.title.toUpperCase(),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  model.authors!.isNotEmpty ? model.authors![0].name! : "",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            placeholder: (context, url) => const LoadingCard(),
          ),
        ),
        webScreen: SizedBox(
          width: ScreenUtil().screenWidth * 0.08,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              model.formats?.imageJpeg != null ? Container(
                height: 200,
                width: ScreenUtil().screenWidth * 0.08,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: NetworkImage(
                      model.formats!.imageJpeg!,
                    ),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(211, 209, 238, 0.5),
                      offset: Offset(0, 2),
                      blurRadius: 5,
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ) : Container(
                height: 200,
                width: ScreenUtil().screenWidth * 0.08,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(211, 209, 238, 0.5),
                      offset: Offset(0, 2),
                      blurRadius: 5,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    model.title[0],
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
              Text(
                model.title.toUpperCase(),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                model.authors!.isNotEmpty ? model.authors![0].name! : "",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        ),
      );
  }
}
