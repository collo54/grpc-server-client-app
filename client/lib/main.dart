import 'package:flutter/material.dart';
import 'package:proto/proto.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  late ClientChannel _channel;
  late TodoServiceClient _stub;
  Todo? todo;

  @override
  void initState() {
    super.initState();
    _channel = ClientChannel(
      'localhost',
      port: 8080,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    _stub = TodoServiceClient(
      _channel,
    );
  }

  void _getTodo() async {
    // final id = Random().nextInt(100);
    final todo = await _stub.getTodo(
      GetTodoByIdRequest(),
    );
    setState(() {
      this.todo = todo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (todo != null)
              Column(
                children: [
                  Text(todo!.id.toString()),
                  Text(todo!.title.toString()),
                  Text(todo!.completed.toString()),
                ],
              )
            else
              const Text('get your todo'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getTodo,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
