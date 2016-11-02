//: Playground - noun: a place where people can play

import UIKit

/*
 结构和类的区别
 相同点
 1.都是在定义一种类型
 2.都可以在内部定义属性和方法
 3.都可以定义下标运算
 4.都可以定义初始化方法(初始化器, 构造器, init)
 5.都可以扩展现有功能(Swift中的扩展 就是 OC中的分类)
 6.都可以遵守协议
 不同点
 1.类可以继承，而结构不能继承
 2.类有多态，结构没有
 3.类的内存管理支持自动引用计数器，使用ARC。而结构的内存不需要我们去管理，内存是在栈中分配的，出了作用域会自动释放
 */

//结构体是值类型
struct Resolution {
    var width = 0
    var height = 0
}
//结构的逐一初始化器   编译默认提供， 逐一初始化器可以对结构中属性进行 逐一初始化
var resolution = Resolution.init(width: 1, height: 2)
var resolution2 = Resolution()
var resolution3 = Resolution(width: 1, height: 2)

//类是引用类型
class VideoMode {
    //类中的属性必须初始化, 直接在声明初始化 或者 在 init初始化器中初始化
    //如果不初始化必须是可选值，默认用nil来初始化可选值
    var resolution = Resolution()
    var interloaced = false
    var frameRate = 0.0
    var name : String?
}
var videoMode = VideoMode()
videoMode.resolution //. 不在是OC中 .语法没有对应 setter getter 方法



//swift 属性分类  有两种方式
/*
 第一种分类方式
 存储属性 （Stored Properties）
 用变量或长量保存属性值
 
 计算属性  (Calculate Properties)
 不用变量保存  属性的值是计算出来的
 
 出生日期 : 存储属性
 年龄    : 计算属性  通过出生日期计算出来
 
 第二种
 实例属性  (instance properties)
 类型属性  (type properties)
 
 属性附加 : 属性监视器 (properties observer)
 用于探知属性的值是否发生了变化
 */

/*
 类，结构可以定义存储属性。类，结构，枚举可以定计算属性
 */
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var w = 0.0, h = 0.0
}
var size = Size(w: 100, h: 200)
struct Rect {
    /*存储属性*/
    var origin = Point()
    var size = Size()
    
    //lazy 延迟属性，再使用的时候才会被初始化，类似OC中懒加载或延迟加载
    lazy var view = UIView()
    
    /*计算属性   计算属性可以是可读写， 也可以是只读属性, 如果是只读属性 set可以省略*/
    var center : Point {
        get {
            let centerX = origin.x + size.w * 0.5
            let centerY = origin.y + size.h * 0.5
            return Point(x: centerX, y: centerY)
        }
        //如果自己不接受 newCenter， 编译器会帮我们声明一个值来接收， 用 newValue, 如果自己声明了，编译器就不在帮我声明了
        set /*(newCenter)*/ {
            let originX = newValue.x - size.w * 0.5
            let originY = newValue.y - size.h * 0.5
            origin = Point(x: originX, y: originY)
        }
    }
    //属性监视器,类似KVO
    /*
     是一段代码，这段代码会在属性发生变化时调用，在属性发生变化会自动执行
     1. 计算属性， 延迟属性不能设置属性监视器， 只能给存储属性添加监视器
     2. 属性初始化是不会调用属性监视器
     3. 属性监视器有两种
     willSet / didSet
     4. 一个属性可以写两个监视器，也可以只有其中一个
     */
    var nn : Int = 10 {
        willSet /*(newSetp)*/ { //属性将要发生变化时调用
            print("当前的属性值是 \(nn), 将要变化的值是 \(newValue)")
        }
        didSet /*(oldSetp)*/ {//属性已经变化了 调用
            print("当前的属性值是 \(nn), 变化前的值是 \(oldValue)")
        }
    }
}
var rect = Rect()
rect.origin = Point(x: 100, y: 100)
rect.size = Size(w: 300, h: 300)
rect.center.x
rect.center.y

rect.center = Point(x: 300, y: 300)
rect.origin.x
rect.origin.y

rect.view

rect.nn = 20


//全局变量也可以添加属性监视器
var a : Int = 5 {//全局区
willSet {
    print("属性监视器")
}
}
if a > 1 {
    //局部变量   临时变量 //栈区
    //局部变量也可以添加属性监视器
    var x : Int = 10 {
        willSet {
            print("属性监视器")
        }
    }
    x = 10
}
a = 3


/*
 实例属性
 结构或类中的没有被关键字修饰的属性都是实例属性(之前用的都是实例属性， 是OC中的实例变量)
 
 类型属性
 类型属性在结构或枚举中用static来修饰，在类用class修饰
 结构中 类型属性可以是存储属性， 也可以是计算属性
 类中的 用类型属性不可以定义存储属性，只能计算属性
 类型属性是类的  用类名访问
 ************
 每个类的某一个类型属性在内存只有一份   [对象 isKindof:［类名 class］/*类对象*/]
 [类名 class] 类对象
 类名 ＊变量 ＝ ［类名 alloc］类的对象（实例）
 （runtime 运行时）
 *************
 
 实例属性是属于实例   用实例访问
 */
struct SomeStruct {
    var storedProp = 0
    var calculateProp : Int {
        return 100
    }
    //类型属性
    static var storedProp2 = 0
    static var calculateProp2 : Int {
        return 100
    }
}
var someStruct = SomeStruct()
someStruct.storedProp
someStruct.calculateProp
//类型属性使用 类名访问
SomeStruct.storedProp2
SomeStruct.calculateProp2


class SomeClass {
    //类中类型属性不能定义为存储属性
    //    class var caluclateProp = 10
    static var caluclateProp2 = 100//特例，使用static修饰后变为类型属性
    class var caluclateProp : Int {
        return 12345
    }
}
SomeClass.caluclateProp2
//类型属性 用类名访问
SomeClass.caluclateProp
var som = SomeClass()

class SSomeClass: SomeClass {
    static var i = 0
}


//方法和属性类似，使用class或static修饰后变为类方法
//swift 中 类 结构 枚举都可以用方法
//方法分 实例方法 和  类型方法
class Counter {
    var count = 0
    func increment() {
        //我们加不加self. 编译器都会帮我们加上,
        count
        //通过self首先找到引用对象的内存地址，再去该地址中找到对象属性
        self.count += 1
    }
    func increment(amount : Int) {//方法重载
        count += amount
    }
    class func reset() ->Int {
        return 1
    }
}
var counter = Counter()
counter.increment()
Counter.reset()


//在值类型的实例方法中 修改实例属性
//值类型 之的是 结构 和 枚举
//值类型的属性 默认不可以在 实例方法中修改
//如果要在值类型的实例方法中修改实例属性，在方法前加 mutating 关键字
//值类型实例方法分为 只读方法 和 可修改方法

struct PPoint {
    var x = 0.0, y = 0.0
    mutating func set(X x : Double, andY y : Double) {
        print(self.x)
        self.x = x
        self.y = y
    }
}
var point = PPoint()
point.set(X: 100, andY: 200)


enum StaticSwitch {
    case Study, Dining, Deview, Sleep
    
    func show() {
        switch self {
        case .Study:
            print("正在学习中")
        case .Dining:
            print("正在吃饭中")
        case .Deview:
            print("正在复习中")
        case .Sleep:
            print("正在休息中")
        }
    }
    
    mutating func nextAction() {
        switch self {
        case .Study:
            self = .Dining
        case .Dining:
            self = .Deview
        case .Deview:
            self = .Sleep
        case .Sleep:
            self = .Study
        }
    }
    
}
var staticSwitch = StaticSwitch.Study
staticSwitch.show()
staticSwitch.nextAction()
staticSwitch.show()
staticSwitch.nextAction()
staticSwitch.show()



//supscript //附属脚本  下标运算符 []
struct Metrix {
    var grid : [Double]
    var rows : Int , columns : Int
    init(rows : Int, columns : Int) {
        self.rows = rows
        self.columns = columns
        grid = [Double](count: rows * columns, repeatedValue: 0.0)
    }
    
    //判断下标是否越界 没有越界返回true
    func indexIsValidForRow(row : Int, col : Int) ->Bool {
        return row >= 0 && row < self.rows && col >= 0 && col < self.columns
    }
    
    //有点类似方法和属性的结合体
    subscript(row row : Int, col : Int)->Double {
        get{
            //断言 不用进数组的断言
            assert(indexIsValidForRow(row, col: col), "Metrix index out of range")
            return grid[row * self.columns + col]
        }
        set {
            assert(indexIsValidForRow(row, col: col), "Metrix index out of range")
            grid[row * self.columns + col] = newValue
        }
    }
}
var metrix = Metrix(rows: 3, columns: 3)
for i in 0 ..< 3 {
    for j in 0 ..< 3 {
        metrix[row: i, j] = Double(i * 100 + j)
    }
}
//[]下标运算符，触发附属脚本
metrix[row: 0, 1]
metrix[row: 1, 1]
metrix[row: 2, 1]
//metrix[3, 3]//触发断言



//继承、多态
//子类重写父类方法 需要加 override, 可以检查重写是否正确
//重写父类的计算属性 也需要加 override
//父类存储属性不可以重写，但是可以重写属性监视器,如果原来没有就是添加属性监视器


//父类中使用 final 修饰的属性，不能重写属性监视器
//父类中使用 final 修饰的方法 子类不能重写
//使用 final 修饰的类 不能被继承




//初始化器
/*
 1.如果一个类或结构中，我们没有写任何的初始化器，那么编译会帮我提供，类的话编译器会提供一个无参数的初始化器， 结构编译器会提供无参和逐一初始化器
 2.如果我们提供了至少一个初始化器，编译器就不再帮我们提供任何的初始化器
 3.初始化器不需要调用，创建对象会调用对应的初始化
 4.初始化器是自动调用
 */


//类中的属性必须初始化，可以在声明初始化，也可以在初始化器中初始化
//有些变量无法在对象创建时初始化，必须声明称可选值

//委托初始化器，传入的参数不一定是属性的值，会根据传入的参数初始化属性或者在委托初始化器中生成初始化器所需参数，然后调用初始化器

/*
 类的初始化器
 指定初始化器  和  遍历初始化器
 规则:
 1.遍历初始化器必须调用同一个类中定义的其他初始化器
 2.遍历初始化器必须最终以调用一个指定构造器结束
 3.指定初始化器必须调用其直接父类的初始化器
 */

//子类的初始化一定会调用父类的初始化器,如果我们没有调用父类的初始化，编译器会默认调用父类的无参数的初始化器

class Food {
    var name : String
    //指定初始化器
    init(name : String) {
        self.name = name
    }
    //遍历初始化器
    convenience init() {
        self.init(name: "米饭")
    }
}

class RecipeIngredient: Food {
    var quantity : Int
    //给子类再添加一个指定初始化器
    init(name: String, quantity: Int) {
        //swift中必须先初始化本类属性，在调用父类的初始化
        self.quantity = quantity
        super.init(name: name)
        //父类初始化器调用后， 可以对父类的属性重新赋值
//        self.name = "酱油"
    }
    
    //重写父类的指定初始化器(如果愿意，还可以将其更改为遍历初始化器)
    override init(name: String) {
        self.quantity = 1
        super.init(name: name)
    }
    
    //注意
    //指定构造器中不能再调用其他指定构造器
    //如果子类中没有定义任何指定构造器，那么父类中的所有指定构造器和遍历构造都会被继承下来
    //如果子类中有指定构造器，那么父类中的构造器不会被继承下来
    //如果子类重写了父类中所有的指定构造器，那么父类的所有遍历构造器也会被继承下来
}

var recipeIngredient = RecipeIngredient(name: "辣椒", quantity: 10)
recipeIngredient.name
recipeIngredient.quantity

var recipe2 = RecipeIngredient.init(name: "白菜")//父类的初始化器已经被重写
recipe2.name
recipe2.quantity

var recipe3 = RecipeIngredient.init()//父类的遍历初始化器仍然可用
recipe3.name


//可失败的初始化器
struct Animal {
    var name : String
    //可失败的初始化器, 有可能返回nil
    init?(name : String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}
var animla : Animal? = Animal(name: "旺财")
animla?.name//可选链


class SomeClass2 {
    required init(name : String) {}
}
class Child : SomeClass2 {
    init() {
        super.init(name: "abc")
    }
    //当子类有自己的指定构造器时，父类 required 修饰的初始化器，子类必须重写
    required init(name: String) {
        super.init(name: name)
    }
}
var child = Child.init(name: "123")

/*
 值类型的初始化器
 逐一初始化器  委托初始化器
 引用类型的初始化器
 指定构造   遍历构造器
 */

class A {
    init?() {
        print("对象 A 创建")
    }
    deinit {//相当于dealloc
        print("A 销毁")
    }
}


//此类可以在任何地方使用，包括项目外都可以访问
public class AClass{}
//此类只能本项目内部访问，或框架内部访问，相当于原来 pulbic
internal class BClass{}
//嵌套类型 类里可以有结构体和内部类
//默认 internal
class DClass {
    //此类只能本类内部使用
    private class CClass{}
    func test () {
        let c = CClass()
        print(c)
    }
}

public class FClass {
    //属性的访问选前不能高于 类的访问权限
    public var a = 10
    internal var b = 20
    private var c = 30
}
var f = FClass()


//item as? Movie 父类引用 转换 为子类的引用， 如果该父类引用确实引用是要转换的子类的对象，那么会直接转换，如果不是，会返回nil， 既然可以返回nil，就说明返回的是可选值


//AnyObject  Any
//AnyObject 可以代表任何class类型的实例(相当于OC的NSObject)
//Any 可以放任何东西 可以 值类型 可以是 引用类型（比NSObject牛逼）




//扩展，相当于OC的分类
extension Double {
    //不可以扩展存储属性
    //可以扩展计算属性
    var km : Double {
        return self * 1000
    }
    var cm : Double {
        return self / 100
    }
    var mm : Double {
        return self / 1000
    }
}

extension Int {
    //扩展方法
    func repeatitions(function : ()->()) {
        for _ in 0..<self {
            //执行事件 ?
            function()
        }
    }
}
10.repeatitions{ () -> () in
    print("abcd")
}

extension Rect {
    //扩展初始化器
    init(x : Double, y : Double, w : Double, h : Double) {
        let origin = Point()
        let size = Size()
        self.origin = origin
        self.size = size
    }
}
var rect2 = Rect(x : 100, y : 100, w : 200, h : 200)

//扩展下标运算符
extension UIView {
    subscript(index : Int) ->UIView {
        return self.subviews[index]
    }
}
var parentView = UIView()
parentView.addSubview(UIImageView())
parentView.addSubview(UIButton())
parentView[1]




//协议
protocol MyProtocol {
    //协议中属性只能是 计算属性, 不能是存储属性
    var prop : Int {get set} //可读写计算属性
    var onlyRead : Int {get} //只读计算属性
    //实例方法
    func instanceMethod()->Int
    //类型方法
    static func typeMethod()
    //swift 中 协议中的方法默认都是必须实现的方法
}
struct SomeStruct2 : MyProtocol {
    var prop : Int
    var onlyRead : Int
    func instanceMethod() -> Int {
        return 10
    }
    static func typeMethod() {
        
    }
}
var someStruct2 = SomeStruct2(prop: 100, onlyRead: 200)
someStruct2.prop
someStruct2.onlyRead
someStruct2.instanceMethod()
//类型方法用类名 和 结构名称调用
SomeStruct2.typeMethod()


//协议中的 初始化器
protocol SomeProtocol {
    init(someParameter : Int)
}
class SomeClass3 : SomeProtocol {
    //实现协议中的初始化器要加required
    required init(someParameter: Int) {}
}

protocol SomeProtocol2 {
    init()
}
class SomeSuperClass {
    init(){}
}
class SomeSubClass : SomeSuperClass , SomeProtocol2 {
    //实现协议中的初始化器，如果父类包含此方法，要加override required
    override required init() {
        
    }
}

//协议扩展  对已有的类进行扩展，增加一个协议
protocol TextRepresentable{
    func asTest() ->String
}
extension UIView : TextRepresentable {
    func asTest() -> String {
        //如果遵守协议的类没有重新实现，就使用这里扩展的实现，但是如果遵守协议的类，自己重新实现了，就用类重新实现的部分
        return "abc"
    }
}
var view = UIView()
view.asTest()


//补充声明
struct Hamster {
    var name : String = "name"
    func asTest()->String {
        return "abc"
    }
}
//补充声明 遵守协议
extension Hamster : TextRepresentable{}


//类专属协议  只有类可以遵守
protocol SomeClassOnlyProtocol : class {}
//struct MyStruct : SomeClassOnlyProtocol {}
class MyClass : SomeClassOnlyProtocol{}

//协议的合并
protocol Named {
    var name : String {get}
}
protocol Aged {
    var age : Int {get}
}

struct Person2 : Named, Aged {
    var name : String = "张三"
    var age : Int = 30
}
func show(celebrator : protocol<Named, Aged>) {
    print("\(celebrator.name) 的年龄是 \(celebrator.age)")
}
show(Person2())


//关于 协议中  可选择实现的方法
//要使用OC中的协议
@objc protocol ObjcProtocol {
    //遵守协议的类 必须实现的方法
    func requiredMethod()
    //遵守协议的类 可选实现的方法
    optional func optionalMethod()
}
class ObjClass : ObjcProtocol {
    @objc func requiredMethod() {}
    //可选实现的方法
    @objc func optionalMethod() {}
}







