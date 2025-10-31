import 'package:flutter/material.dart';
import 'package:super_fitness_app/features/popular_training/presentation/manager/cubit/popular_cubit.dart';
import 'package:super_fitness_app/features/popular_training/presentation/widgets/popular_training_card.dart';

class PopularTrainingListViewBuilder extends StatelessWidget {
  const PopularTrainingListViewBuilder({super.key, required this.data});

  final List<PopularData> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) => PopularTrainingCard(
        imageUrl: data[index].exercises!.first.inDepthYoutubeExplanationLink,
        title: data[index].exercises!.first.primeMoverMuscle,
        level: data[index].level.name,
        tasksCount: data[index].exercises!.length.toString(),
        onTap: () {},
      ),
    );
  }
}
