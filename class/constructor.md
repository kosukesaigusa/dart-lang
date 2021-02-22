# コンストラクタ

## 参考

- [【公式】Dart language specification](https://dart.dev/guides/language/spec)
- [【公式】A tour of the Dart language](https://dart.dev/guides/language/language-tour#constructors)
- [【公式】Language samples](https://dart.dev/samples)
- [【公式】Effective Dart: Style](https://dart.dev/guides/language/effective-dart/style)
- [【公式】Libraries and visibility](https://dart.dev/guides/language/language-tour)
- [Qiita 【Dart メモ】Dart の名前付き引数 (Named Parameter)](https://qiita.com/akatsukaha/items/497b8990f2a97f64d8d3)
- [DevelopersIO](https://dev.classmethod.jp/articles/about_dart_constructors/)
- [わわわ IT 用語辞典](https://wa3.i-3-i.info/word13646.html)
- [Flutter 入門](https://flutter.keicode.com/dart/constructor.php)
- [Let's プログラミング](https://www.javadrive.jp/start/constructor/index1.html)

## コンストラクタとは

コンストラクタ (constructor) とは、オブジェクト指向のプログラミング言語に存在する用語のひとつであり、インスタンス（オブジェクト）を作成したタイミングで実行されるメソッドのことを指す。つまり、ざっくり言うと、クラスを `new` した瞬間（dart では省略可能）に実行される関数のことである。

## Dart のコンストラクタ

Dart のコンストラクタは次の 3 種類

- Generative コンストラクタ
- Factory コンストラクタ
- Constant コンスタラクタ

に分類される。

Generative コンストラクタは、最もよくあるコンストラクタで、クラス名と同じ関数名で次のように記述する。`this` のキーワードは、現在取り扱っているインスタンスを指している。`this` キーワードは[【公式】Effective Dart: Style](https://dart.dev/guides/language/effective-dart/style) に従って、変数名の被りがあるとき以外には用いないようにする。

```dart
class Point {
    double x, y;

    Point (double x, double y) {
        this.x = x;
        this.y = y;
    }
}
```

コンストラクタの関数の引数に指定した変数を、インスタンス変数に割り当てることはよくあるので、より簡易な書き方として、次のようにもして良い。

```dart
class Point {
    double x, y;

    // インスタンス変数 x,y に値を渡しつつ
    // コンストラクタ を定義する簡易な書き方
    Point (this.x, this.y);
}
```

あるクラスに複数のコンストラクタが存在するようなケースや、それをより明確に表現したいときには "Named constructors"（名前付きコンストラクタ）という次のような方法を用いても良い。

```dart
class Point {
    double x, y;

    // 通常のコンストラクタ
    Point(this.x, this.y);

    // 追加のコンストラクタ
    // 原点で対象の点のインスタンスを生成したい
    // といったニュアンス
    Point.origin() {
        x = 0;
        y = 0;
    }
}
```

Factory コンストラクタは、必ずしも毎回新しいインスタンスを生成するわけではないクラスのコンストラクタに使用する。新しいインスタンスを生成しないことがあるというのは、例えば、キャッシュの中からインスタンスを返すような状況である。Factory コンストラクタの典型的な使い方としては、シングルトンを生成するような場合である。

また、コンストラクタの引数として渡しても渡さなくても良い物がある場合には、その引数をオプショナルにするために `[]` で囲むようにする。

```dart
class Person{
    String firstName;
    String lastName;
    int age;

    // コンストラクタ
    // age は渡しても渡さなくても良いことを意味する
    Person(this.firstName, this.lastName, [this.age]);

    sayHello() {
        print('Hello, I\'m $firstName $lastName ($age).');
    }
}

void main() {
    // age は渡さないで
    // Person クラスのインスタンスを生成してみる
    var p = Person('Taro', 'Yamada');
}
```

実行結果：

```
Hello, I'm Taro Yamada (null).
```

また、名前付き引数 (named parameters) を用いて、

```dart
class Person{
    String firstName;
    String lastName;
    int age;

    // 氏名は必須、年齢は必須でない名前付きパラメータによるコンストラクタ
    Person({@required this.firstName, @required this.lastName, this.age});

    sayHello() {
        print('Hello, I\'m $firstName $lastName ($age).');
    }
}

void main() {
    var p = Person(firstName: 'Taro', lastName: 'Yamada');
}
```

実行結果：

```
Hello, I'm Taro Yamada (null).
```

のように、明示的にパラメータ名を指定してコンストラクタを呼び出す（このとき、`firstName` と `lastName` は必須のパラメータ、`age` はそうでないものとして定義し、名前付きパラメータの `{}` で囲んでおり、`main()` の中では `age` を指定せずに呼び出している）こともできる（[参考：Qiita 【Dart メモ】Dart の名前付き引数 (Named Parameter)](https://qiita.com/akatsukaha/items/497b8990f2a97f64d8d3)）。

## getter と setter

getter と setter は、それぞれ、あるオブジェクトのプロパティへの読み・書きを行うことができる特別なメソッドである。それぞれのインスタンスは暗黙的に getter と（適切な場合には）setter を持っている。`get` および `set` のキーワードを用いることで、

```dart
class Rectangle {
    double left, top, width, height;

    // 長方形インスタンスを
    // 左の座標・上の座標・横幅と深さで定義する
    Rectangle(this.left, this.top, this.width, this.height);

    // getter で、新たに右の点のプロパティを計算によって与える
    double get right => left + width;

    // setter で、右の点のプロパティが与えられたときに、左の点を計算し直す
    set right(double value) => left = value - width;

    // getter で、新たに下の点のプロパティを計算によって与える
    double get bottom => top + height;

    // setter で、下の点のプロパティが与えられたときに、上の点を計算し直す
    set bottom(double value) => top = value - height;
}

void main() {
    var rect = Rectangle(3, 4, 20, 15);
    assert(rect.left == 3);
    rect.right = 12;
    assert(rect.left == -8);
}
```

## Factory コンストラクタを用いたシングルトンの生成

シングルトンというのはソフトウェアのデザインパターンの１つで、 あるクラスのインスタンスをアプリケーション内でひとつになるように制限することを指す。例えば、アプリケーショングローバルの状態管理や、データストアの作成など、複数のインスタンスがあると都合が悪い状況で用いられる。

下の例では、何かの記録を行うための `Logger` クラスを Factory コンストラクタを用いて定義している。クラス変数としては `String` 型の `name` と `String` 型の `message` という変数が存在している。このクラスには、

- クラスと同名の `Logger()` という名前の Factory コンストラクタ
- `fromJson()` という名前付きの Factory コンストラクタ
- `_internal()` という名前付きの Generative コンストラクタ（アンダースコア `_` で始まるので当該クラス外から呼び出すことはない）

という 3 つのコンストラクタが記述されている。

このクラス内だけで用いられる `Map<String, Logger オブジェクト>` 型の変数 `_cache` はからのマップ `{}` として初期化されている。

はじめの `Logger()` の Factory コンストラクタでは、`_cache` の Map にまだ該当のキーが登録されていない場合には（それが `map.putIfAbsent(key, () => new_value)` の意味である。[`putIfAbsent method` を参照](https://api.dart.dev/stable/2.10.5/dart-core/Map/putIfAbsent.html)）、コンストラクタの引数によって与えられた文字列のキー（`name` の中身）をキーとして、メッセージの文字列の値 (`message` の中身) とともに生成した `Logger` クラスのインスタンスとして追加して `_cache` 変数を上書きした上で、`Logger` クラスのインスタンスを返すといった処理が書かれている。

次の `Logger.fromJson()` の Factory コンストラクタでは、引数として `Map<String, Object>` 型の json を受け取って実行し、その json の `name` キーの値と `message` キーの値を引数として、上で説明した Factory コンストラクタ `Logger()` を実行することで `Logger` クラスのインスタンスを返す、といった処理内容である。

さいごの `Logger._internal(this.name)` は、`Logger` クラス内においてプライベートな `_internal()` という名前付きの Generative コンストラクタである。つまり、このクラスの外からは、`Logger()._internal(name: some_name)` というふうにして `Logger` クラスのインスタンスを自由に生成することはできず、`Logger()` コンストラクタは Factory コンストラクタであるため、当該アプリケーション内では `Logger` クラスのインスタンスはひとつに限定されることになる。

```dart
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

    void testLoggerClass() {
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
    }
}

void main() {
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
}
```

実行結果：

```
A message from UI.
A message from UI.
A message from UI.
```

実行結果から、`main()` の中で`logger1`, `logger2`, `loggerJson` というふうに異なる名前の異なるインスタンスを生成しているように見えて、すべてはじめに Factory コンストラクタで生成した同一のインスタンスにアクセスしているという事がわかる。
