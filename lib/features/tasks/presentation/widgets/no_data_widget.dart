import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Sem tarefas',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 40,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SvgPicture.asset(
            'assets/images/no_data.svg',
            height: 300,
          ),
        ],
      ),
    );
  }
}
