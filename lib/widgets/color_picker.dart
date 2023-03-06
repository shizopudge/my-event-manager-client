import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/add_event/color_picker_cubit.dart';

const List<Color> colors = [
  Colors.blueGrey,
  Colors.red,
  Colors.grey,
  Colors.deepPurple,
  Colors.teal,
  Colors.blue,
  Colors.deepOrange,
  Colors.pink,
];

class ColorPicker extends StatelessWidget {
  const ColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: GridView.builder(
        itemCount: colors.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          final Color color = colors[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => context.read<AddEventColorPickerCubit>().pickColor(
                    color
                        .toString()
                        .split('MaterialColor(primary value: Color(')[1]
                        .split('))')[0],
                  ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(21),
                  child: ColoredBox(color: color)),
            ),
          );
        },
      ),
    );
  }
}
