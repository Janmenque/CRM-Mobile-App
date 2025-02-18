import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget(
      {Key? key,
        this.image =
        'https://i.pinimg.com/originals/75/4f/ef/754fef5ccbae781570e74e57a85d2720.jpg',
        this.title,
        this.subTitle})
      : super(key: key);

  final String? image;
  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeInImage.assetNetwork(
          placeholder: 'assets/images/ic_loader.gif',
          image: image!,
        ),
        Text(
          title!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            subTitle!,
            style: const TextStyle(fontSize: 16, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}