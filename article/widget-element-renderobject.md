## Widget

> Describes the configuration for an Element.
> Widgets are the central class hierarchy in the Flutter framework. A widget is an immutable description of part of a user interface. Widgets can be inflated into elements, which manage the underlying render tree.

`Widget` 的实际工作就是描述如何创建 `Element`，`Widget` 是一个不可变对象，它可以被复用（不是指渲染的时候将对象从旧树中拿过来放到新树，而是在同一个 Widget Tree 中，某个子 `Widget` 可以出现多次，因为它只是一个 description）。即使 Widget 被重复使用，框架还是会创建多个不同的 `Element` 对象。比如，一个给定的Widget可以放置在树中多次，比如：多个TextWidget。每次将一个Widget放入树中时，它都会被扩充到一个Element中，这也意味着多次入树中的Widget将会被多次扩充进对应的element。

构建 widget 的过程并不耗费资源，因为 Wiget 只是用来保存属性的容器。

Widget都是 immutable的，所以 Widget节点的改变其实就是节点的销毁和重建。Widget的更新和移除等操作，会用Widget的两个属性:runtimeType和key来进行对比判断。

> Widget中的Key这个属性控制一个Widget如何替换树中的另一个Widget。如果两个Widget的runtimeType和key属性相等（==），则新的widget通过更新Element（即通过使用新的Widget调用Element.update）来替换旧的Widget。否则，如果两个Widget的runtimeType和key属性不相等，则旧的Element将从树中被移除，新的Widget将被扩充到一个新的Element中，这个新的Element将被插入树中。



## Element

相对于Widget来说，Flutter创建Element树是可变的。

Widget与Element之间的关系：Element是Widget的实例, Element才是真正干活的，执行widget的部署。

通常开发中，我们不直接操作Element,而是由框架层实现内部逻辑。Widget Tree 发生变化的时候，Flutter Framework 通过 `Element` 来更新，只会标记 dirty Element，而不会标记 dirty Widget。所以 Widget无状态，而 Element有状态。

> 比如Widget更新后，Element持有该 Widget的节点会被标记为 dirty Element，那么在下一个周期的 draw Frame时，Element树的这一部分子树便会被触发 performRebuild。在 Element树更新完成后，便能获得 RenderObject树，接着进行布局绘制。

Element生命周期：

> 父Element重新创建了新状态，框架层将调用新的Widget的update方法。新Widget将始终具有与旧Widget相同的runtimeType和key属性。如果父Element希望在树中的此位置更改Widget的runtimeType或key，可以通过unmounting(卸载)此Element并在此位置扩充新Widget来实现。

> 若Element被视为“激活的”，并可能出现在屏幕上。Element被视为“无效状态”，不会出现在屏幕上。一个Element可以保持”非活动"状态，直到当前动画帧结束。在动画帧结束时，任何仍处于非活动状态的Element都将被卸载清除，且将来不会并入树中。

 Element存放Widget上下文，通过遍历视图树，Element 同时持有 Widget 和 RenderObject。

Element property包含renderObject和widget，renderObject是RenderObject类型（如果此对象是RenderObjectElement，则渲染对象是树中此位置处的对象。否则，这个getter将沿着树走下去，直到找到一个RenderObjectElement），widget是Widget类型，是这个Element的配置信息。



## RenderObject

它就是负责视图渲染的。所有的布局、绘制和事件响应全都由它负责，开发复杂视图时我们可能经常需要与之打交道。Flutter中大部分的绘图性能优化发生在这里。

RenderObject是由 `Element` 的子类 `RenderObjectElement` 创建出来的，`RenderObject` 也会构成一个 Render Tree，并且每个 `RenderObject` 也都会被保存下来以便在更新时复用。

`RenderObject`在经过 paint生成 Layer后，会通过 `dart:ui`的 `SceneBuilder`挂载到 LayerTree。RenderObject树构建的数据会被加入 Engine所需的 LayerTree中，Engine通过 LayerTree进行视图合成并光栅化，提交给 GPU。