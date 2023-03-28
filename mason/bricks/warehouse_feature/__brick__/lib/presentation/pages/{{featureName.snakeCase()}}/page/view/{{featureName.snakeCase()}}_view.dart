import 'package:flu_warehouse_mobile/presentation/pages/{{featureName.snakeCase()}}/page/widgets/{{featureName.snakeCase()}}_cell.dart';
import 'package:flutter/material.dart';

class {{featureName.pascalCase()}}View extends StatelessWidget {
  const {{featureName.pascalCase()}}View({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => const {{featureName.pascalCase()}}Cell(),
        ),
      );
}
