import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<IconData> icons = [
    Icons.home,
    Icons.star,
    Icons.settings,
    Icons.person,
    Icons.phone,
  ];
  int? draggedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: icons.asMap().entries.map((entry) {
            int index = entry.key;
            IconData icon = entry.value;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: LongPressDraggable<int>(
                data: index, // The index of the dragged item
                feedback: Icon(
                  icon,
                  color: Colors.blueAccent,
                  size: 50,
                ), // Icon displayed while dragging
                childWhenDragging:
                    Container(), // Empty space when the icon is being dragged
                onDragStarted: () {
                  setState(() {
                    draggedIndex = index; // Mark the icon that is being dragged
                  });
                },
                onDragCompleted: () {
                  setState(() {
                    draggedIndex = null; // Clear the dragged index
                  });
                },
                child: DragTarget<int>(
                  onAccept: (fromIndex) {
                    setState(() {
                      // Swap icons when dropped
                      var temp = icons[fromIndex];
                      icons[fromIndex] = icons[index];
                      icons[index] = temp;
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Icon(
                      icon,
                      size: 50,
                      color: index == draggedIndex ? Colors.grey : Colors.black,
                    );
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
