import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/pages/my_group/presentation/widgets/my_group_card.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MyGroupScreen extends StatefulWidget {
  const MyGroupScreen({super.key});

  @override
  State<MyGroupScreen> createState() => _MyGroupScreenState();
}

class _MyGroupScreenState extends State<MyGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovableBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(title: 'My Groups'),
              MyGroupCard(),
            ],
          ),
        ),
      ),
    );
  }
}
