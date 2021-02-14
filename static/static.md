# static キーワード

# 参考

- [【公式】A tour of the Dart language](https://dart.dev/guides/language/language-tour#class-variables-and-methods)

## static キーワードとは

`static` キーワードを用いることで、クラスワイドな変数やメソッドを実装することができる。

## static 変数 (static variables)

下記のように、あるクラスの変数に `static` キーワードを付加して定義することで、インスタンスごとに保持されるのではなく、クラスで 1 つの実体を持つことを保証した意味合いで変数を定義することができる。なお、static 変数は（コンパイル時に定義される const 変数と異なり）呼び出されるまでは初期化されない。

```dart
class Queue {
    static const initialCapacity = 16;
    // ···
}

void main() {
    assert(Queue.initialCapacity == 16);
}
```

## static メソッド (static methods)

static メソッドは、インスタンス上で実行されることはなく、そのため `this` キーワードを用いることもできない。その代わり、そのクラスの static 変数にアクセスすることができる。次の例では、2 点間の距離を測るためのメソッド `distanceBetween()` が static メソッドとして定義されているが、`Point()` というインスタンスをコンストラクトすることなく、計算が実行されているのが分かる。

```dart
import 'dart:math';

class Point {
    double x, y;
    Point(this.x, this.y);

    static double distanceBetween(Point a, Point b) {
        var dx = a.x - b.x;
        var dy = a.y - b.y;
        return sqrt(dx * dx + dy * dy);
    }
}

void main() {
    var a = Point(2, 2);
    var b = Point(4, 4);
    var distance = Point.distanceBetween(a, b);
    assert(2.8 < distance && distance < 2.9);
    print(distance);
}
```

static メソッドは コンパイル時の定数としても使えるので、例えば Constant コンストラクタのパラメータとしても使用することができる。
