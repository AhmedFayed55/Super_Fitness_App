import 'package:flutter/material.dart';

class CategoryBar extends StatelessWidget {
  const CategoryBar({super.key});

  @override
  Widget build(BuildContext context) {
    var categories = CategoryModel.getCategory();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Category", style: Theme.of(context).textTheme.displaySmall),
        Container(
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xff242424),
          ),
          child: ListView.separated(
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(categories[index].image,width: 60,),
                  Text(categories[index].name),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 20,
                child: VerticalDivider(
                  endIndent: 8,
                  indent: 8,
                  thickness: 1,
                  color: Color(0xff2D2D2D),
                ),
              );
            },
            itemCount: categories.length,
          ),
        ),
      ],
    );
  }
}

class CategoryModel {
  String image;
  String name;

  CategoryModel({required this.image, required this.name});

  static List<CategoryModel> getCategory() {
    return [
      CategoryModel(
        image: "assets/images/gym.png",
        name: "Gym",
      ),
      CategoryModel(
        image: "assets/images/fitness.png",
        name: "Fitness",
      ),
      CategoryModel(
        image: "assets/images/yoga.png",
        name: "Yoga",
      ),
      CategoryModel(
        image: "assets/images/aerobics.png",
        name: "Aerobics",
      ),
      CategoryModel(
        image: "assets/images/trainer.png",
        name: "Trainer",
      ),
    ];
  }
}
