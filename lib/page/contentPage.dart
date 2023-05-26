import 'package:book_hunt/models/bookModel.dart';
import 'package:book_hunt/models/categoryTiles.dart';
import 'package:book_hunt/utils/colors.dart';
import 'package:book_hunt/utils/components/bookCard.dart';
import 'package:book_hunt/utils/responsiveLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../provider/repositoryProvider.dart';
import '../utils/components/loadingCard.dart';

class ContentPage extends ConsumerStatefulWidget {
  final GenreModel model;

  const ContentPage({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ContentPageState();
}

class _ContentPageState extends ConsumerState<ContentPage> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  BooksModel? model;
  int page = 1;
  bool fetchingNewData = false, noResults = false;
  String? searchQuery = "";
  List<Widget> books = [];

  String urlEncodeString(String input) {
    return Uri.encodeComponent(input);
  }

  @override
  void initState() {
    fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (!isTop && searchQuery!.isEmpty) {
          setState(() {
            fetchingNewData = true;
            page++;
            fetchData();
          });
        }
      }
    });
    super.initState();
  }

  void fetchData() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        noResults = false;
      });
      await ref
          .read(repositoryProvider)
          .getBooks(
            category: widget.model.title,
            page: page,
          )
          .then((value) {
        if (value!.isNotEmpty) {
          for (Results e in value) {
            setState(() {
              books.add(
                BookCard(
                  model: e,
                ),
              );
            });
          }
        }
        setState(() {
          fetchingNewData = false;
        });
      });
    });
  }

  void searchData() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref
          .read(repositoryProvider)
          .searchData(
            page: page,
            category: widget.model.title,
            query: urlEncodeString(searchQuery!).toLowerCase(),
          )
          .then((value) {
        if (value!.isNotEmpty) {
          for (Results e in value) {
            setState(() {
              books.add(
                BookCard(
                  model: e,
                ),
              );
            });
          }
        } else {
          setState(() {
            noResults = true;
          });
        }
        setState(() {
          fetchingNewData = false;
        });
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScreen: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: SvgPicture.asset(
                "assets/images/Back.svg",
                fit: BoxFit.contain,
              ),
            ),
          ),
          leadingWidth: 35,
          title: Text(
            widget.model.title,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          bottom: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.white,
            elevation: 0,
            title: Container(
              width: double.infinity,
              color: Colors.white,
              child: TextField(
                controller: searchController,
                showCursor: true,
                cursorColor: AppColors.darkGrey,
                onChanged: (value) {
                  setState(() {
                    books.clear();
                    searchQuery = value;
                  });
                  searchQuery!.isEmpty ? fetchData() : searchData();
                },
                onSubmitted: (value) {
                  setState(() {
                    books.clear();
                    searchQuery = value;
                  });
                  searchQuery!.isEmpty ? fetchData() : searchData();
                },
                decoration: InputDecoration(
                  fillColor: AppColors.lightGrey,
                  filled: true,
                  hintText: 'Search',
                  isCollapsed: false,
                  isDense: true,
                  hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.grey,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: AppColors.lightGrey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                    ),
                  ),
                  prefixIconConstraints:
                      BoxConstraints.tight(const Size(40, 40)),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: SvgPicture.asset(
                      "assets/images/Search.svg",
                      fit: BoxFit.contain,
                    ),
                  ),
                  suffixIcon: searchController.text != ""
                      ? IconButton(
                          onPressed: () {
                            if (searchController.text != "") {
                              setState(() {
                                searchController.clear();
                                searchQuery = "";
                                books.clear();
                                noResults = false;
                              });
                              fetchData();
                            }
                          },
                          splashRadius: 20,
                          icon: Icon(
                            Icons.clear,
                            color: AppColors.darkGrey,
                            size: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .fontSize,
                          ),
                        )
                      : Container(),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: books.isEmpty
              ? Center(
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: loadingList,
                  ),
                )
              : Center(
                  child: noResults
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No results found.",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              children: books,
                            ),
                            fetchingNewData
                                ? const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 5,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                ),
        ),
      ),
      webScreen: Scaffold(
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Container(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenHeight / 4,
                color: AppColors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                    ),
                                    child: SvgPicture.asset(
                                      "assets/images/Back.svg",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.model.title,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: TextField(
                                controller: searchController,
                                showCursor: true,
                                cursorColor: AppColors.darkGrey,
                                onChanged: (value) {
                                  setState(() {
                                    books.clear();
                                    searchQuery = value;
                                  });
                                  searchQuery!.isEmpty
                                      ? fetchData()
                                      : searchData();
                                },
                                onSubmitted: (value) {
                                  setState(() {
                                    books.clear();
                                    searchQuery = value;
                                  });
                                  searchQuery!.isEmpty
                                      ? fetchData()
                                      : searchData();
                                },
                                decoration: InputDecoration(
                                  fillColor: AppColors.lightGrey,
                                  filled: true,
                                  hintText: 'Search',
                                  isCollapsed: false,
                                  isDense: true,
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: AppColors.grey,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                      color: AppColors.lightGrey,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  prefixIconConstraints:
                                      BoxConstraints.tight(const Size(40, 40)),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: SvgPicture.asset(
                                      "assets/images/Search.svg",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  suffixIcon: searchController.text != ""
                                      ? IconButton(
                                          onPressed: () {
                                            if (searchController.text != "") {
                                              setState(() {
                                                searchController.clear();
                                                searchQuery = "";
                                                books.clear();
                                                noResults = false;
                                              });
                                              fetchData();
                                            }
                                          },
                                          splashRadius: 20,
                                          icon: Icon(
                                            Icons.clear,
                                            color: AppColors.darkGrey,
                                            size: Theme.of(context)
                                                .textTheme
                                                .headlineSmall!
                                                .fontSize,
                                          ),
                                        )
                                      : Container(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                  ],
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
                    child: Center(
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: books.isEmpty ? loadingList : books,
                      ),
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
        ),
      ),
    );
  }
}
