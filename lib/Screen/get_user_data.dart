import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draggable Scrollable Sheet Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return DraggableScrollableSheet(
                  initialChildSize: 0.5,  // The initial height is 50% of the screen
                  minChildSize: 0.5,  // The minimum height is 50% of the screen
                  maxChildSize: 1.0,  // The maximum height is 100% of the screen
                  expand: false,
                  builder: (context, scrollController) {
                    return Container(
                      color: Colors.white,
                      child: ListView.builder(
                       controller: scrollController,
                        itemCount: 50,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('Item $index'),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            );
          },
          child: Text('Show Bottom Sheet'),
        ),
      ),
    );
  }
}
