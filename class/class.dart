/// `dart <対象のファイル>.dart` コマンドで実行
/// または `.vscode/tasks.json` を 設定して `cmd` + `shift` + `B` で実行可能

/// getter と setter の練習 ////////////////////////////////////////////////////////////
/// Rectangle クラス
class Rectangle {
  double left, top, width, height;

  // 長方形インスタンスを
  // 左の座標・上の座標・横幅と深さで定義する
  Rectangle(this.left, this.top, this.width, this.height);

  // getter: 新たな right プロパティを取得する
  double get right => left + width;

  // setter: right プロパティが与えられたときに、left プロパティの値を再度セットする
  set right(double value) => left = value - width;

  // getter: 新たな bottom プロパティを取得する
  double get bottom => top + height;

  // setter: bottom プロパティが与えられたときに、top プロパティの値を再度セットする
  set bottom(double value) => top = value - height;

  // getter: 新たな area プロパティを取得する
  double get area => width * height;
}

void testGetterAndSetter() {
  print('--- getter and setter ---');
  var rect = Rectangle(3, 4, 20, 15);
  print('rect.left: ${rect.left}');
  rect.right = 12; // right プロパティに対する setter の実行
  print('rect.right: ${rect.right}');
  print('rect.left: ${rect.left}');
  print('rect.area: ${rect.area}');
  print('---');
}
////////////////////////////////////////////////////////////////////////////////////////

/// Factory コンストラクタの練習////////////////////////////////////////////////////////
/// Logger クラス
class Logger {
  final String name;
  final String message;

  // _cache is library-private, thanks to
  // the _ in front of its name.
  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name, String message) {
    return _cache.putIfAbsent(name, () => Logger._internal(name, message));
  }

  factory Logger.fromJson(Map<String, Object> json) {
    return Logger(json['name'].toString(), json['message'].toString());
  }

  Logger._internal(
    this.name,
    this.message,
  );

  void printMessageFromCache(String key) {
    print(_cache[key]?.message);
  }
}

void testFactoryConstructor() {
  print('--- Factory constructor ---');
  var logger1 = Logger('UI', 'A message from UI.');
  var logger2 = Logger('UI', 'Another message from UI');

  var logMap = {
    'name': 'UI',
    'message': 'Message from UI by fromJson constructor'
  };
  var loggerJson = Logger.fromJson(logMap);

  logger1.printMessageFromCache('UI');
  logger2.printMessageFromCache('UI');
  loggerJson.printMessageFromCache('UI');
  print('---');
}
////////////////////////////////////////////////////////////////////////////////////////

/// main() 関数
void main() {
  testGetterAndSetter();
  testFactoryConstructor();
}
