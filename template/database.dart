class MySubPage extends StatefulWidget {
  const MySubPage({super.key});

  @override
  State<MySubPage> createState() => _MySubPageState();
}

class _MySubPageState extends State<MySubPage> {
  int _counter = 0;
  late Database _database;

  @override
  void initState() {
    super.initState();
    databaseFactory = databaseFactoryFfi;
    InitDatabase();
  }

  Future<void> InitDatabase() async {
    _database = await openDatabase(
        'counter_database.db',
        version: 1,
        onCreate: (Database db, int ver) {
          return db.execute('CREATE TABLE conters(id INTEGER PRIMARY KEY, count INTEGER)');
        },
        onOpen: (Database db) {debugPrint("openDatabase");}
    );
    
    // データベースから取得
    List<Map<String, dynamic>> records = await _database.query('conters');
    if (records.isNotEmpty) { // 空じゃなかったとき
      setState(() {
        _counter = records.first['count'];
      });
    }
    else {
      _save();
    }
  }

  Future<void> _save() async {
    await _database.insert('conters', {'count': _counter});
  }

  Future<void> _add() async {
    setState(() {
      _counter++;
    });

    List<Map<String, dynamic>> records = await _database.query('conters');
    var value = records.first['count'];
    debugPrint("dbに増やす前: " "{$value}");
    await _database.update('conters', {'count': _counter});
  }

  void _nextPage() {
    setState(() {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("さぶ"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .start,
          children: [
            const Text('さぶう:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextField(textAlign: TextAlign.center, onChanged: (text) {
              debugPrint("changed");
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("たいとる"),
                      content: Text("ないよう"),
                      actions: [
                        TextButton(child: Text("キャンセル"), onPressed: () {},),
                        TextButton(child: Text("OK"), onPressed: () {})
                      ],);
                  });
            }),
            TextButton(onPressed: _add, child: Text("ふやす"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _nextPage,
        tooltip: 'Increment',
        child: const Icon(Icons.remove),
      ),
    );

  }

}
