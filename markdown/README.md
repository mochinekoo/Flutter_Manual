# dartの基本
* import
* function： ```() {}```
* late：非null

# 
* デバックのバナー非表示（MaterialApp）： ```debugShowCheckedModeBanner: false```

# 
* Widget：画面
* Scaffold
* AppBar：上のバー
* FloatingActionButton：画面上にあるボタン

* Column：縦に並べる
* Row：横に並べる
* Stack：Widgetを重ねる
* Center：中央揃え

# ダイアログ
```dart
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
```
