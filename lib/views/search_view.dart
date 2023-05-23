import 'package:flutter/material.dart';
import 'package:wallpaper_app/controller/api.dart';
import 'package:wallpaper_app/model/photo_model.dart';
import 'package:wallpaper_app/views/full_wall_view.dart';
import 'package:wallpaper_app/views/home_view.dart';
import 'package:wallpaper_app/widgets/custom_app_bar.dart';
import 'package:wallpaper_app/widgets/search_bar.dart';

// ignore: must_be_immutable
class SearchView extends StatefulWidget {
  String search_;
  SearchView({super.key, required this.search_});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<PhotoModel> searchResult = [];
  bool isLoading = true;
  bool isInvalidSearch = false;
  getSearchResult() async {
    searchResult = await ApiOperations.searchWallpaper(widget.search_);
    setState(() {
      isLoading = false;
      isInvalidSearch = searchResult.isEmpty && !isLoading;
    });
  }

  @override
  void initState() {
    super.initState();
    getSearchResult();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeView()),
          (Route<dynamic> route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomeView()),
                  (Route<dynamic> route) => false,
                );
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: const App_Bar(),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : isInvalidSearch
                ? Center(
                    child: Text(
                      'No results found for "${widget.search_}"',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .06,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Search_Bar(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: 720,
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: searchResult.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 400,
                                    crossAxisSpacing: 13,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) => InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullWallView(
                                        imgUrl: searchResult[index].imgSrc),
                                  )),
                              child: Hero(
                                tag: searchResult[index].imgSrc,
                                child: Container(
                                  height: 1500,
                                  width: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      searchResult[index].imgSrc,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
      ),
    );
  }
}
