# flutter summary



- `Dart` 属于是**强类型语言** ，但可以用 `var`  来声明变量，`Dart` 会**自推导出变量的数据类型**，`var` 实际上是编译期的“语法糖”。**dynamic 表示动态类型**， 被编译后，实际是一个 `object` 类型，在编译期间不进行任何的类型检查，而是在运行期进行类型检查。

- `Dart` 中 `if` 语句只支持 `bool` 类型，`switch` 支持 String 类型。
- `Dart` 中**数组和 List 是一样的。**
- `Dart` 中，**Runes 代表符号文字** ,  是 UTF-32 编码的字符串, 用于如 `Runes input = new Runes('\u{1f596} \u{1f44d}');`
- **Dart 支持闭包。**
- `Dart` 中 number 类型分为 **int 和 double ，没有 float 类型。**
- `Dart` 中 **级联操作符** ，如下代码：

```
event
  ..id = 1
  ..type = "a"
  ..actor = "";
```



- `is` 运算符，a is b，用于判断 a 对象是否是 b 类的实例，返回 bool 值
- `as` 运算符用于检查类型`(emp as Person).firstName = 'Bob';` 
- ??= 运算符

```
  b ??= value; // 如果 b 为空，把 value 赋值给 b;
               // 否则，b 不变
```

- ?? 运算符

  ```
    String toString() => msg ?? super.toString();
    //如果 msg 不为空，返回 msg；否则返回后面的
  ```

- ~/

  ```
  AA ~/999  //AA 对于 999 整除
  ```

- ?.运算符,**避免左边操作数为null引发异常**
  ```
    var str1 = "hello world";
    var str2 = null;
    print(str1?.length); // 11
    print(str2?.length); // null 
    print(str2.length); // 报错
  ```

- 作用域
  **Dart 没有关键词 public 、private 等修饰符，_ 下横向直接代表 private ，但是有 @protected 注解 。**

- getter /setter 

  `Dart` 中所有的基础类型、类等都继承 `Object` ，默认值是 `NULL`， 自带 `getter` 和 `setter` ，而如果是 `final` 或者 `const` 的话，那么它只有一个 `getter` 方法，`Object`  都支持 getter、setter 重写

- 继承、类、接口

  `Dart` 中没有接口，类都可以作为接口，把某个类当做接口实现时，只需要使用 `implements` ，然后复写父类方法即可。
  `Dart` 中支持 `mixins` ，按照出现顺序应该为`extends` 、 `mixins(with)` 、`implements` 。

- **构造函数不能被继承，子类不会继承父类的构造函数。如果不显式提供子类的构造函数，系统就提供默认的构造函数**。

- 使用命名构造函数可以实现一个类多个构造函数。构造函数不能被继承，父类中的命名构造函数不能被子类继承。如果想要子类也拥有一个父类一样名字的构造函数，必须在子类实现这个构造函数。

-  **抽象类**
> 使用abstract关键字定义一个抽象类，抽象类不能实例化。抽象类通常用来定义接口

- ### Zone
 `Dart` 中可通过 `Zone` 表示指定代码执行的环境，类似一个沙盒概念，在 `Flutter` 中 **C++** 运行 `Dart` 也是在 `_runMainZoned` 内执行 `runZoned` 方法启动，而我们也可以通过 `Zone` ，在运行环境内捕获全局异常等信息:

```
  runZoned(() {
    runApp(FlutterReduxApp());
  }, onError: (Object obj, StackTrace stack) {
    print(obj);
    print(stack);
  });
```
  同时你可以给 `runZoned` 注册方法，在需要时执行回调，如下代码所示，这样的在一个 `Zone` 内任何地方，只要能获取 `onData` 这个 `ZoneUnaryCallback`，就都可以调用到 `handleData`

```
///最终需要处理的地方
handleData(result) {
  print("VVVVVVVVVVVVVVVVVVVVVVVVVVV");
  print(result);
}

///返回得到一个 ZoneUnaryCallback 
var onData = Zone.current.registerUnaryCallback<dynamic, int>(handleData);

///执行 ZoneUnaryCallback 返回数据
Zone.current.runUnary(onData, 2);

```

  异步逻辑可以通过 `scheduleMicrotask` 可以插入异步执行方法：

```
Zone.current.scheduleMicrotask((){
  //todo something
});
```



- ### Future

  [async](https://docs.flutter.io/flutter/dart-async/dart-async-library.html), `Future` 简单了说就是对 `Zone` 的封装使用。比如 `Future.microtask` 中主要是执行了 `Zone` 的 `scheduleMicrotask` ，而 `result._complete` 最后调用的是 `_zone.runUnary` 等等。

   `Dart `中可通过 async/await 或者 Future 定义异步操作，而事实上 async/await 也只是语法糖，最终还是通过编译器转为 Future。

```
  factory Future.microtask(FutureOr<T> computation()) {
    _Future<T> result = new _Future<T>();
    scheduleMicrotask(() {
      try {
        result._complete(computation());
      } catch (e, s) {
        _completeWithErrorCallback(result, e, s);
      }
    });
    return result;
  }
```

- **Stream**

  `Stream` 也是有对`Zone` 的另外一种封装使用。

  **Dart 中另外一种异步操作， async\* / yield 或者 Stream 可定义 Stream 异步，  async* / yield 也只是语法糖，最终还是通过编译器转为 Stream。** **Stream 还支持同步操作。**

  `Stream` 中主要有 `Stream` 、 `StreamController` 、`StreamSink` 和 `StreamSubscription` 四个关键对象：

  - **StreamController** ：如类名描述，用于整个  `Stream` 过程的控制，提供各类接口用于创建各种事件流。
  - **StreamSink** ：一般作为事件的入口，提供如 `add`   ，   `addStream`   等。
  - **Stream** ：事件源本身，一般可用于监听事件或者对事件进行转换，如 `listen` 、`where` 。
  - **StreamSubscription** ：事件订阅后的对象，表面上用于管理订阅过等各类操作，如 `cacenl` 、`pause` ，同时在内部也是事件的中转关键。

  **一般通过 StreamController 创建 Stream；通过 StreamSink 添加事件；通过 Stream 监听事件；通过 StreamSubscription 管理订阅。**

  `Stream` 中支持各种变化，比如`map` 、`expand` 、`where` 、`take` 等操作，同时支持转换为 `Future` 。





- Flutter UI是直接通过 skia 渲染的.

- Flutter 中存在 `Widget` 、 `Element` 、`RenderObject` 、`Layer` 四棵树，其中 **Widget 与 Element 是多对一的关系** ，

- `Element`  中持有`Widget` 和 `RenderObject` ， 而 **Element 与 RenderObject 是一一对应的关系** ，

- 当 `RenderObject` 的 `isRepaintBoundary` 为 `true` 时，那么个区域形成一个 `Layer`，所以**不是每个 RenderObject 都具有 Layer 的，因为这受 isRepaintBoundary 的影响。**

- Flutter 中 `Widget` 不可变，每次保持在一帧，如果**发生改变是通过 State 实现跨帧状态保存**，而**真实完成布局和绘制数组的是 RenderObject ，**  `Element` 充当两者的桥梁， **State 就是保存在 Element 中。**

- **Flutter 中的 BuildContext 只是接口，而  Element  实现了它。**

- Flutter 中 **setState  其实是调用了 markNeedsBuild**  ，该方法内部**标记此Element 为 Dirty** ，然后在下一帧 `WidgetsBinding.drawFrame` 才会被绘制，这可以看出 **setState 并不是立即生效的。**

- Flutter 中一般 **json** 数据从 `String` 转为 `Object` 的过程中都需要先经过 `Map` 类型。

- Flutter 中 `InheritedWidget` 一般用于**状态共享**，如`Theme` 、`Localizations` 、 `MediaQuery` 等，都是通过它实现共享状态，这样我们可以通过 `context` 去获取共享的状态，比如 `ThemeData theme = Theme.of(context);`

- **flutter 生命周期**

   **initState()** 表示当前 `State` 将和一个 `BuildContext` 产生关联，但是此时`BuildContext` 没有完全装载完成，如果你需要在该方法中获取 `BuildContext` ，可以 `new Future.delayed(const Duration(seconds: 0, (){//context});` 。

    **didChangeDependencies()** 在 `initState()` 之后调用，当 `State` 对象的依赖关系发生变化时，该方法被调用，初始化时也会调用

     **deactivate()** 当 `State` 被暂时从视图树中移除时，会调用这个方法，同时页面切换时，也会调用。

     **dispose()**  Widget 销毁了，在调用这个方法之前，总会先调用 deactivate()。

     **didUpdateWidge** 当  `widget` 状态发生变化时，会调用。

![](images\stateful-state.png)

- Flutter 中 `runApp` 启动入口其实是一个 `WidgetsFlutterBinding` ，它主要是通过 `BindingBase` 的子类 `GestureBinding`  、`ServicesBinding`  、 `SchedulerBinding`  、`PaintingBinding`  、`SemanticsBinding`  、 `RendererBinding`  、`WidgetsBinding` 等，通过 `mixins` 的组合而成的。
- Flutter 中的 Dart 的线程是以**事件循环和消息队列**的形式存在，包含两个任务队列，**一个是 microtask 内部队列，一个是 event 外部队列，而 microtask 的优先级又高于 event 。**

> 因为 microtask 的优先级又高于 event， 同时会阻塞event 队列，所以如果 microtask 太多就可能会对触摸、绘制等外部事件造成阻塞卡顿哦。

- Flutter 中存在**四大线程，分别为 UI Runner、GPU Runner、IO Runner， Platform Runner （原生主线程）** ，同时在 Flutter 中可以通过 `isolate` 或者 `compute` 执行真正的跨线程异步操作。



