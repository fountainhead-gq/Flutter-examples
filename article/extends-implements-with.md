# extends-with-implements

在Flutter中，有如下三种关系：

1. 继承（关键字 extends）
2. 混入 mixins （关键字 with）
3. 接口实现（关键字 implements）

这三种关系可以同时存在，但是有前后顺序：

extends ->  mixins -> implements

extends在前，mixins在中间，implements最后，接下来看具体的例子。

## 1. 继承(extends)

Flutter中的继承和Java中的继承是一样的：

1. Flutter中的继承是单继承
2. 构造函数不能继承
3. 子类重写超类的方法，要用`@override`
4. 子类调用超类的方法，要用`super`

Flutter中的继承也有和Java不一样的地方：

1. Flutter中的子类可以访问父类中的所有变量和方法，因为Flutter中没有公有、私有的区别

讲完特性，看下面的代码加深理解：

```
class Television {
  void turnOn() {
    _illuminateDisplay();
  }
  
  void _illuminateDisplay(){
  }
}

class SmartTelevision extends Television {
  void turnOn() {
    super.turnOn();
    _bootNetworkInterface();
  }
  
  void _bootNetworkInterface(){
  }
}
```

## 2.混合 mixins (with)

在Flutter 中：

1. 混合的对象是类
2. 可以混合多个

看具体代码：

```
class Television {
  void turnOn() {
    _illuminateDisplay();
  }
  
  void _illuminateDisplay(){
  }
}

class Update{
  void updateApp(){

  }
}

class Charge{

  void chargeVip(){

  }
}

class SmartTelevision extends Television with Update,Charge  {

  void turnOn() {
    super.turnOn();
    _bootNetworkInterface();
    updateApp();
    chargeVip();
  }
  
  void _bootNetworkInterface(){
  }

}
```

## 3.接口实现(implements)

Flutter是没有interface的，但是Flutter中的每个类都是一个隐式的接口，这个接口包含类里的所有成员变量，以及定义的方法。

如果有一个类 A,你想让类B拥有A的API，但又不想拥有A里的实现，那么你就应该把A当做接口，类B implements 类A.

所以在Flutter中:

1. class 就是 interface
2. 当class被当做interface用时，class中的方法就是接口的方法，需要在子类里重新实现，在子类实现的时候要加`@override`
3. 当class被当做interface用时，class中的成员变量也需要在子类里重新实现。在成员变量前加`@override`
4. 实现接口可以有多个

看如下的代码：

```
class Television {
  void turnOn() {
    _illuminateDisplay();
  }
  
  void _illuminateDisplay(){
  }
}

class Carton {
  String cartonName = "carton";

  void playCarton(){

  }
}

class Movie{
  void playMovie(){

  }
}

class Update{
  void updateApp(){

  }
}

class Charge{

  void chargeVip(){

  }
}

class SmartTelevision extends Television with Update,Charge implements Carton,Movie {
  @override
  String cartonName="SmartTelevision carton";

  void turnOn() {
    super.turnOn();
    _bootNetworkInterface();
    updateApp();
    chargeVip();
  }
  
  void _bootNetworkInterface(){
  }

  @override
  void playCarton() {
    // TODO: implement playCarton
  }

  @override
  void playMovie() {
    // TODO: implement playMovie
  }

}
```

