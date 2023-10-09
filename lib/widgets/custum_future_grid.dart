import 'package:album_manager/widgets/custom_grid.dart';
import 'package:flutter/material.dart';

class CustomFutureGrid<T> extends StatelessWidget {
  final Future<List<T>> list;
  final Widget Function(T element) card;
  final String erroreMessage;

  const CustomFutureGrid({Key? key, required this.list, required this.card, required this.erroreMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: list,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(erroreMessage));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Nessun elemento disponibile"));
        } else {
          return CustomGrid(
              card: (index) {
                dynamic element = snapshot.data![index];
                return card(element);
              },
              count: snapshot.data!.length);
        }
      },
    );
  }
}
