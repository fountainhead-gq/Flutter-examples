# runApp

不管 Flutter 开发完整应用还是作为区块嵌入某个页面，都需要调用 `runApp` ，而我们需要做的只是传入一个 Widget 实例，那么 `runApp` 背后所做的工作就很有趣了，比如触发视图的构建、更新以及绘制等，下面我们就粗略地看一下这个函数到底做了啥。

## runApp 

先看一下 `runApp` 的函数声明：

```dart
void runApp(Widget app) {
    WidgetsFlutterBinding.ensureInitialized()
        ..attachRootWidget(app)
        ..scheduleWarmUpFrame();
}
```

`WidgetsFlutterBinding` 使用了 [mixin](https://yahdude.github.io/Blog/post/1e4790f7473c20aa35d72cf542d39ab4)，将负责点击事件、绘制的 **XXXBinding** 组合起来，这个类也使用了单例模式，即 `ensureInitialized`。

调用 `attachRootWidget` 将会触发 Widget、Element、RenderObject 的构建 调用 `scheduleWarmUpFrame` 会触发视图的第一帧上屏，同时因为是第一帧，也会伴随着一些初始化操作，所以这个函数相对一般的绘制耗时较长

## attachRootWidget

从 `runApp` 声明了解到 `WidgetFlutterBinding` 真正启动 Flutter 应用的入口，接着看 `attachRootWidget` 函数：

```dart
void attachRootWidget(Widget rootWidget) {
    _renderViewElement = RenderObjectToWidgetAdapter<RenderBox>(
        container: renderView,
        debugShortDescription: '[root]',
        child: rootWidget
    ).attachToRenderTree(buildOwner, renderViewElement);
}
```

`RenderObjectToWidgetAdapter` 继承于 `RenderObjectWidget` ，只是起到一个 **桥接** 的作用，正如它的类名一样，而起到桥接作用的正是 `attachToRenderTree` 函数：

```dart
RenderObjectToWidgetElement<T> attachToRenderTree(BuildOwner owner, [RenderObjectToWidgetElement<T> element]) {
    if (element == null) {
        owner.lockState(() {
            element = createElement();
            assert(element != null);
            element.assignOwner(owner);
        });
        owner.buildScope(element, () {    // 刚刚初始化
            element.mount(null, null);
        });
    } else {
        element._newWidget = this;
        element.markNeedsBuild();
    }
    return element;
}
```

应用第一次启动时，传入的 `element` 为 `null` ，所以这里分析的是第一个分支。首先会创建 `RenderObjectToWidgetElement`实例，然后调用 `assignOwner` 进行赋值（这个 buildOwner 非常重要，整个 Widget 树中的节点都会持有同一个实例），最后会调用 `mount` 挂载成为 ElementTree 的根结点。

在看 `RenderObjectToWidgetElement#mount` 之前，先看下它的继承链：

```dart
Element
└── RenderObjectElement
    └── RootRenderObjectElement
        └── RenderObjectToWidgetElement
```

先看 `RenderObjectToWidgetElement.mount`：

```dart
void mount(Element parent, dynamic newSlot) {
    assert(parent == null);
    super.mount(parent, newSlot);
    _rebuild();
}
void _rebuild() {
    try {
        _child = updateChild(_child, widget.child, _rootChildSlot);
    } catch (exception, stack) {
        final Widget error = ErrorWidget.builder(details);
        _child = updateChild(null, error, _rootChildSlot);  // 这个就是运行异常时看到的 error 屏
    }
}
```

这里通过`updateChild`方法创建 child，这里会进行一个 **递归调用** 完成整个树构建/更新。

然后是 `RootRenderObjectElement.mount` 方法：

```dart
void mount(Element parent, dynamic newSlot) {
    // Root elements should never have parents.
    assert(parent == null);
    assert(newSlot == null);
    super.mount(parent, newSlot);
}
```

这里只是做了简单的参数检查。

> 有些文章把 `assert` 语句去掉了，其实有一些是不能省略的，使用 `assert` 做一些工作是为了提升性能，因为在开发阶段完成检查后，生产环境就可以避免这些操作而提高性能了

接着看 `RenderObjectElement.mount`：

```dart
void mount(Element parent, dynamic newSlot) {
    super.mount(parent, newSlot);
    _renderObject = widget.createRenderObject(this);
    attachRenderObject(newSlot);    // 挂载 RenderObject 节点到🌲上
    _dirty = false;
}
```

这个类类名有 **RenderObject** 字眼，恰好 `mount` 方法里创建了 `RenderObject` 实例。

最后就是 `Element` 基类了，这个类的 `mount` 方法很简单，就是针对树这种数据结构完成子节点的挂载。

所以，`attachRootWidget` 会完成 Widget、Element、RenderObject 树🌲的创建，这里要注意的是只是完成的和创建，并没有的进行测量、布局等，这些都是在下一个函数调用中进行的。

## scheduleWarmUpFrame

完成了三颗tree的构建，接下里的就是的完成 Flutter 的上屏，即绘制、渲染。

直接看 `scheduleWarmFrame` 的函数定义：

```dart
void scheduleWarmUpFrame() {
    // ...
    handleBeginFrame(null);
    handleDrawFrame();
    // ...
    lockEvents(() async {   // 在第一帧渲染完成之前，所有的事件，如点击事件都不会进行分发
        // ...
    });
}
```

上面代码做了一定程度精简。

在开始分析这个函数之前，先了解下一些 **Callbacks** ，上面函数声明在 `SchedulerBinding` 里，这个 mixin 主要负责一些任务调度，这些任务都以 **Callback** 的形式存在，有四种任务类型： - Transient callbacks： 由 `Window.onBeginFrame` 触发，目的是同步应用状态和显示，比如动画 - Persistent callbacks： 由 `Window.onDrawFrame` 触发，更新显示，渲染任务 - Post-frame callbacks： 在 Persistent callbacks 执行完后执行，有且只执行一次 - Non-rendering tasks： 普通任务，它们会在两帧之间按照优先级顺序被执行

那么 `Window.onXXXFrame` 又是什么？

```dart
mixin SchedulerBinding{
    @override
    void initInstances() {
        // ...
        ui.window.onBeginFrame = _handleBeginFrame;
        ui.window.onDrawFrame = _handleDrawFrame;
        // ...
    }
    void _handleBeginFrame(Duration rawTimeStamp) {
        // ...
        handleBeginFrame(rawTimeStamp);
    }

    void _handleDrawFrame() {
        // ...
        handleDrawFrame();
    }
}
```

其实就是 `ScheduleBinding` 的方法，知道这些了我们接着前面继续分析：

```dart
void handleBeginFrame(Duration rawTimeStamp) {
    // ...
    try {
        final Map<int, _FrameCallbackEntry> callbacks = _transientCallbacks;
        _transientCallbacks = <int, _FrameCallbackEntry>{};
        callbacks.forEach((int id, _FrameCallbackEntry callbackEntry) {
            if (!_removedIds.contains(id))
                _invokeFrameCallback(callbackEntry.callback, _currentFrameTimeStamp, callbackEntry.debugStack);
        });
        _removedIds.clear();
    } finally {
        // ...
    }
}

void handleDrawFrame() {
    // ...
    try {
        for (FrameCallback callback in _persistentCallbacks)
            _invokeFrameCallback(callback, _currentFrameTimeStamp);

        final List<FrameCallback> localPostFrameCallbacks = List<FrameCallback>.from(_postFrameCallbacks);
        _postFrameCallbacks.clear();
        for (FrameCallback callback in localPostFrameCallbacks)
            _invokeFrameCallback(callback, _currentFrameTimeStamp);
    } finally {
        // ...
    }
}
```

所以 `scheduleWramUpFrame` 最终会执行这些回调，渲染、绘制将由这些回调/任务来完成，那么这些回调又是在哪里注册的呢？

因为负责渲染的回调/任务属于 **persistent callback** ，所以可以到 `RendererBinding` 中找下 `addPersistentFrameCallback` 的调用，果然在初始化的时候进行了注册：

```dart
mixin RendererBinding on BindingBase, SchedulerBinding,... {
    @override
    void initInstances() {
        // ...
        initRenderView();
        // ...
        addPersistentFrameCallback(_handlePersistentFrameCallback);
    }
    void _handlePersistentFrameCallback(Duration timeStamp) {
        drawFrame();
    }
    @protected
    void drawFrame() {
        assert(renderView != null); // renderView 是整个 RenderObject 树的根节点
        pipelineOwner.flushLayout();   //  布局
        pipelineOwner.flushCompositingBits();   // 更新状态，是否需要重绘等
        pipelineOwner.flushPaint(); // 对需要绘制的节点进行绘制
        renderView.compositeFrame(); // this sends the bits to the GPU
        pipelineOwner.flushSemantics(); // this also sends the semantics to the OS.
  }
}
```

## Recap

到这里，从启动到第一帧上屏就算是完了，整个流程非常清晰。在分析的过程中，我们忽略了 `BuildOwner` 和 `PipelineOwner`，这两个类贯穿树的构建和绘制，不过这篇文章对它们进行深入分析并不合适，之后会通过分析界面更新来分析它们的作用。

还有一点值得提起的是，除了 Widget、Element、RenderObject 树之后，还有一颗 Layer 树。Flutter 会根据这颗树构建一个 `Scene`，最后渲染并上屏。