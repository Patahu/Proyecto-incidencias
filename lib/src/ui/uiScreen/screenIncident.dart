import 'package:flutter/material.dart';

import 'themas.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
  
        Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, right: 16, left: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: DesignCourseAppTheme.grey.withOpacity(0.2),
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 6.0),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                child: AspectRatio(
                  aspectRatio: 1.28,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
