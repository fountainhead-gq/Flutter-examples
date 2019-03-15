# Widget-Element-RenderObject-1

Flutter的理念是一切都是`Widget`(Everythin is Widget)。使用 Flutter 开发时，接触最多的就是 Widget，但是 Widget 并不会最终显示在屏幕上。Flutter 大量借鉴 React ，React 中有 Component、Virtual DOM 和 tag，Flutter 中对应地有 Widget、Element 以及 RenderObject，所以这篇文章就简单理解下这三者在视图渲染中的作用。

## Widget

先看看源码注释：

```dart
Describes the configuration for an [Element].
Widgets are the central class hierarchy in the Flutter framework. A widget is an immutable description of part of a user interface. Widgets can be inflated into elements, which manage the underlying render tree.
```

大概的意思就是 Widget 只是起到配置的作用的，并且是 imutable 的，所以从 Widget 到屏幕上的像素中间还会经过几次转换。

我们再看下 Widget 的声明：

```dart
@immutable
abstract class Widget extends DiagnosticableTree {
  const Widget({ this.key });
  final Key key;

  @protected
  Element createElement();

  static bool canUpdate(Widget oldWidget, Widget newWidget) {
    return oldWidget.runtimeType == newWidget.runtimeType
        && oldWidget.key == newWidget.key;
  }
}
```

去掉注释，核心代码十行不到。Widget 只是配置，在真正渲染界面的时候会转换成 Element，也即 `createElement` 方法；同时一个 Widget 可以在 Widget 树中多次出现，那么相应的，`createElement` 也会被调用多次。

### 派生类

再看看 Widget 的派生类：

```dart
Widget
    ├── ProxyWidget
    ├── StatelessWidget
    ├── StatefulWidget
    └── RenderObjectWidget
```

**ProxyWidget** 起组装作用。 如类名一样，这个类使用了代理模式，它不会自己构建 Widget ，而是直接返回子 Widget 。

**StatelessWidget** 起组装作用。 这个 Widget 不需要处理内部数据/状态，所以当配置相同时，会有相同构建产物。

**StatefulWidget** 起组装作用。 当 Widget 需要管理内部数据/状态时，就使用这个。即使配置相同，它当构建产物也可能因为内部数据/状态不同而不同。

**RenderObjectWidget** Widget 只是配置，所以有些 Widget ，比如 ProxyWidget ,和视图基本没有关系，也即和视图显示相关的 Widget 叫做 RenderObjectWidget。

同时这个类多了一个 `RenderObject createRenderObject(BuildContext context)` 方法，预示从这个类开始和视图显示有点关系了。

## Element

```dart
An instantiation of a [Widget] at a particular location in the tree.

Widgets describe how to configure a subtree but the same widget can be used to configure multiple subtrees simultaneously because widgets are immutable. An [Element] represents the use of a widget to configure a specific location in the tree. Over time, the widget associated with a given element can change, for example, if the parent widget rebuilds and creates a new widget for this location.
```

大概意思是：Element 是 Widget 在视图中的体现，同时 Element 也管理着视图树的构建、更新等。Widget 是 immutable，而 Element 是 mutable，当 Widget 配置有变化时，Element Tree 会采用一种 **diff 算法** 进行增量更新而不是整个重建。

再看看它的派生类：

```dart
Element
    ├── ComponentElement
    │   ├── ProxyElement
    │   ├── StatelessElement
    │   └── StatefulElement
    └── RenderObjectElement
```

这里和之前的 Widget 是一一对应的，并且这里出现了 **component** 字眼，清楚这个继承关系能够加深 Flutter Framework 层设计的理解。

## RenderObject

还是先看源码注释：

```dart
An object in the render tree.

The [RenderObject] class hierarchy is the core of the rendering library's reason for being.

[RenderObject]s have a [parent], and have a slot called [parentData] in which the parent [RenderObject] can store child-specific data, for example,the child position. The [RenderObject] class also implements the basic layout and paint protocols.

The [RenderObject] class, however, does not define a child model. It also doesn't define a coordinate system or a specific layout protocol.
```

RenderObject 就是负责最后的视图渲染了，视图的测量、布局和绘制都是由它来完成的。不过 RenderObject 本身只是定义了标准，具体的由子类实现，比如一般情况下有线性布局、Flex 布局等，这些都是由 RenderObject 的派生类来实现的。

## Summary

这里简单总结下，Flutter 的视图体系中由三棵树，Widget Tree、Element Tree 以及 RenderObject Tree，Widget Tree 可以产生 Element Tree，并且节点是一一对应的，Element Tree 调用 Widget Tree 创建 RenderObject Tree，但并不是每个 Widget、Element 节点都会有一个 RenderObject 节点与之对应。后续视图的状态、更新等都是由 Element Tree 来进行管控的，而视图显示到屏幕上则是由 RenderObject Tree 负责。