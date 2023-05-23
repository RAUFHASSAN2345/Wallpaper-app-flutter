import 'package:flutter/material.dart';
import 'package:wallpaper_app/controller/api.dart';
import 'package:wallpaper_app/model/photo_model.dart';
import 'package:wallpaper_app/views/full_wall_view.dart';
import 'package:wallpaper_app/widgets/custom_app_bar.dart';

// ignore: must_be_immutable
class CatgView extends StatefulWidget {
  String catgName;
  String catgImgUrl;
  CatgView({super.key, required this.catgName, required this.catgImgUrl});

  @override
  State<CatgView> createState() => _CatgViewState();
}

class _CatgViewState extends State<CatgView> {
  late List<PhotoModel> categoryResults;
  bool isLoading = true;
  // ignore: non_constant_identifier_names
  GetCatRelWall() async {
    categoryResults = await ApiOperations.searchWallpaper(widget.catgName);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    GetCatRelWall();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                        widget.catgImgUrl,
                        height: 150,
                        width: mq.width,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: 150,
                        width: mq.width,
                        color: Colors.black38,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'category',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                              Text(
                                '${widget.catgName}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 30,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 620,
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: categoryResults.length,
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
                                  imgUrl: categoryResults[index].imgSrc),
                            )),
                        child: Hero(
                          tag: categoryResults[index].imgSrc,
                          child: Container(
                            height: 1500,
                            width: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                categoryResults[index].imgSrc,
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
    );
  }
}
