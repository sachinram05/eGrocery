import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchTitle extends StatelessWidget {
  const SearchTitle(
      {super.key, required this.title, required this.onChangeHandler});

  final String title;
  final Function onChangeHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            CupertinoSearchTextField(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              padding: const EdgeInsets.all(12),
              style: const TextStyle(fontSize: 18),
              onChanged: (value) {
                onChangeHandler(value);
              },
              placeholder: 'Search',
            ),
          ],
        ));
  }
}
