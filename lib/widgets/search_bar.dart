import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/search_view.dart';

// ignore: camel_case_types
class Search_Bar extends StatefulWidget {
  const Search_Bar({super.key});

  @override
  State<Search_Bar> createState() => _Search_BarState();
}

class _Search_BarState extends State<Search_Bar> {
  TextEditingController searchEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: searchEditingController,
        style: const TextStyle(fontSize: 19, letterSpacing: 0.5),
        decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(66, 192, 192, 192),
            suffixIcon: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchView(
                          search_: searchEditingController.text,
                        ),
                      ));
                }
              },
              child: const Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              ),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 20, horizontal: mq.width * .05),
            border: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromARGB(33, 13, 5, 5), width: 1),
                borderRadius: BorderRadius.circular(25)),
            hintStyle: const TextStyle(color: Colors.black),
            hintText: 'Search Wallpapers'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please search a wallpaper';
          }
          return null;
        },
        onFieldSubmitted: (value) {
          if (_formKey.currentState!.validate()) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchView(
                    search_: searchEditingController.text,
                  ),
                ));
          }
        },
      ),
    );
  }
}
