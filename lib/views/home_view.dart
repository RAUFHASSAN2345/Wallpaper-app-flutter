import 'package:flutter/material.dart';
import 'package:wallpaper_app/controller/api.dart';
import 'package:wallpaper_app/model/catg_model.dart';
import 'package:wallpaper_app/model/photo_model.dart';
import 'package:wallpaper_app/views/full_wall_view.dart';
import 'package:wallpaper_app/widgets/category_widget.dart';
import 'package:wallpaper_app/widgets/custom_app_bar.dart';
import 'package:wallpaper_app/widgets/search_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<CategoryModel> CatModList = [];
  bool isLoading = true;

  GetCatDetails() async {
    CatModList = await ApiOperations.getCategoriesList();

    setState(() {
      CatModList = CatModList;
    });
  }

  List<PhotoModel> trendWallLst = [];
  getTrendWallLst() async {
    trendWallLst = await ApiOperations.getTren_Wallp();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getTrendWallLst();
    GetCatDetails();
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const App_Bar(),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Search_Bar(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(
                        height: 50,
                        width: mq.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: CatModList.length,
                          itemBuilder: (context, index) => Category_(
                            catgImgSrc: CatModList[index].catImgUrl,
                            catgName: CatModList[index].catName,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: 650,
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: trendWallLst.length,
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
                                    imgUrl: trendWallLst[index].imgSrc),
                              )),
                          child: Hero(
                            tag: trendWallLst[index].imgSrc,
                            child: Container(
                              height: 1500,
                              width: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  trendWallLst[index].imgSrc,
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
