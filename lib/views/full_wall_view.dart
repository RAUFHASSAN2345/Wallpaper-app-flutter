// ignore_for_file: use_build_context_synchronously

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gallery_saver/gallery_saver.dart';

// ignore: must_be_immutable
class FullWallView extends StatefulWidget {
  String imgUrl;
  FullWallView({super.key, required this.imgUrl});

  @override
  State<FullWallView> createState() => _FullWallViewState();
}

class _FullWallViewState extends State<FullWallView> {
  var location_;

  setWallpaper() async {
    try {
      var file = await DefaultCacheManager().getSingleFile(widget.imgUrl);
      await AsyncWallpaper.setWallpaperFromFile(
        filePath: file.path,
        wallpaperLocation: location_,
      ).then((value) async {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Wallpaper Applied Successfully")));
        await GallerySaver.saveImage(widget.imgUrl, albumName: 'My Wallpaper');

        Navigator.pop(context);
        Navigator.pop(context);
      });
    } catch (e) {
      print('error:::::::::: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error Occured : $e')));
    }
  }

  bool ispress = false;
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    widget.imgUrl,
                  ),
                  fit: BoxFit.cover)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ispress == false
            ? ElevatedButton(
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(mq.width * .47, 52)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(mq.width * .08),
                            side: const BorderSide(
                                color: Colors.white, width: 2)))),
                onPressed: () {
                  setState(() {
                    ispress = true;
                  });
                },
                child: const Text(
                  'Set Wallpaper',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ))
            : ElevatedButton(
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(mq.width * .47, 52)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(mq.width * .08),
                            side: const BorderSide(
                                color: Colors.white, width: 2)))),
                onPressed: () {
                  bottomSheet_wallLocatn();
                },
                child: const Text(
                  'Apply',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                )));
  }

  bottomSheet_wallLocatn() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Apply',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 40),
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            location_ = AsyncWallpaper.HOME_SCREEN;
                          });
                          await setWallpaper();
                        },
                        child: const Row(
                          children: [
                            Text(
                              'Home Screen Wallpaper',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            location_ = AsyncWallpaper.LOCK_SCREEN;
                          });
                          await setWallpaper();
                        },
                        child: const Row(
                          children: [
                            Text(
                              'Lock Screen Wallpaper',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          location_ = AsyncWallpaper.BOTH_SCREENS;
                        });
                        await setWallpaper();
                      },
                      child: const Row(
                        children: [
                          Text(
                            'Both',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
