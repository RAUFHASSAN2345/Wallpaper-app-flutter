// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/catg_view.dart';

class Category_ extends StatefulWidget {
  String catgName;
  String catgImgSrc;
  Category_({super.key, required this.catgImgSrc, required this.catgName});

  @override
  State<Category_> createState() => _Category_State();
}

class _Category_State extends State<Category_> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CatgView(
                catgName: widget.catgName, catgImgUrl: widget.catgImgSrc),
          )),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.catgImgSrc,
                height: 50,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Text(
                  '${widget.catgName}',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
