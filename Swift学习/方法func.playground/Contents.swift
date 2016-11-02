//: Playground - noun: a place where people can play

import UIKit

//函数的参数 默认是常量
//声明一个函数 格式
//func 函数名称 (参数) ->返回值类型 {
//    函数体
//}

//可以有一个返回值
//可以有多个返回值, 通过元组返回
func count(string : String) ->(me : Int, you : Int, others : Int)  {
    var me = 0, you = 0, others = 0
    for ch in string.characters {
        switch ch {
        case "我":
            me+=1
        case "你":
            you+=1
        default:
            others+=1
        }
    }
    return (me,you,others)
}
var str2 = "我爱你，我恨你，我想你，我喜欢你"
var result = count(str2)
result.me
result.you
result.others

//externalName 是外部名
//localName 是内部名
//在函数中只能使用内部名
func fb(externalName localName : Int){
    print("\(localName)")
}
//如果参数有外部名，在调用的时候一定要加上外部名
fb(externalName: 100)

/******************************/
//方法重载  多个方法，方法名相同，参数列表不同，就形成重载关系
/*
 参数列表不同:
 参数类型不同
 参数个数不同
 参数顺序不同
 在swift中 外部名不同也可以形成重载的关系
 */



//参数的默认值，如果有默认的值的参数没有传入任何内容，就使用默认值，如果传入了对应的参数，就不再使用默认值，而是使用传进来的
func printArr(a : [Int], flag : Bool = true) {
    if flag {
        print(a)
    }
}

printArr([1, 2])
printArr([1, 2], flag: false)

//可变长参数 ...  可以传任意多个参数
func arithmeticMean(numbers : Double...) ->Double {
    var total : Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
var d = arithmeticMean(1.1, 2.2, 3.3, 4.4, 5.5)


//两值交换  inout输入输出参数(相当于指针)
func mySwap(inout x : Int,inout y : Int) {
    //    let t = x
    //    x = y
    //    y = t
    //两值交换不用第三个变量
    //    x = x + y
    //    y = x - y
    //    x = x - y
    
    
    x = x ^ y
    //    x   0011
    //    y   0101
    //    x = -----------------
    //        0110
    y = x ^ y
    //      x   0110
    //      y   0101
    //    y=-----------   3
    //          0011
    x = x ^ y
    //        x   0110
    //        y   0011
    //    x =------------  5
    //            0101
}
var a = 3
var b = 5
//输入输出参数 传入 前面必须加 & 符号
mySwap(&a, y: &b)
a
b

// 函数类型
var function = mySwap
function(&a, y: &b)


func addTwoInts(a : Int, b : Int) ->Int{
    return a + b
}
func mulTwoInts(a : Int, b : Int) ->Int {
    return a * b
}
func subTowInts(a : Int, b : Int) ->Int {
    return a - b
}

//函数作为参数
func printMathResult(a : Int, b : Int, function : (Int,Int)->Int ) ->Int{
    return function(a, b)
}
printMathResult(100, b: 200, function: subTowInts)

//闭包
printMathResult(100, b: 200) { (a, b) -> Int in
    return a * b
}

printMathResult(100, b: 200, function: {
    (a : Int, b : Int) ->Int in
    return a * b
})

//函数数组
var functions : [(Int,Int)->Int] = [addTwoInts, mulTwoInts, subTowInts]

functions[0](100, 200)

//函数嵌套
func chooseStep2(backward : Bool) ->(Int)->Int {
    //函数中的 函数   作用域在父函数中
    func stepForward(input : Int) ->Int{
        return input + 1
    }
    func setpBackward(input : Int) ->Int {
        return input - 1
    }
    return backward ? setpBackward : stepForward
}

let fu = chooseStep2(false)
fu(1)

/*
 闭包  Closures
 各语言中的闭包函数
 Swift ====> Closures
 Ruby Objective-C  =====> Block
 Python  C++11  =====> Lambda
 Javascript ======> Anonymous Function(匿名函数)
 讲一段代码封装起来，变成一个类似变量的东西，类似一个没有名的函数
 Swift中，如果一个参数是一个函数类型，那么可以将一个功能等同闭包传给它
 Swift中闭包就是函数，但是比函数灵活
 **/


/*
 闭包的语法格式
 {
 (参数列表)->返回类型  in
 逻辑语句
 return xxx
 }
 */
func sortInts(inout data : [Int], function : (Int,Int)->Bool) {
    for i in 0 ..< data.count-1 {
        var flag : Bool = true //假设已经排好
        for j in 0 ..< data.count - i - 1 {
            //            if data[j] < data[j + 1] {
            if function(data[j], data[j + 1]){
                swap(&data[j], &data[j + 1])
                flag = false
            }
        }
        if flag {
            return //如果 flag值时真的 说明之前假设对了， 直接退出就行
        }
    }
}
var c = [1, 9, 6, 3, 8, 7, 2, 4, 5]
func rule(a : Int, b : Int) ->Bool {
    return a > b
}
func rule2(a : Int, b : Int) ->Bool {
    return a < b
}
func rule3(a : Int, b : Int) ->Bool {
    return a + 5 > b
}
sortInts(&c, function :rule3)
c


sortInts(&c, function: {
    (a : Int, b : Int)->Bool in
    return a < b
})
sortInts(&c, function: {
    //参数的类型可以省略，a b 的类型是通过 实际传入的参数推断出来的
    (a, b)->Bool in
    return a < b
})
sortInts(&c, function: {
    //返回值类型可以省略，返回值采用追踪返回值的方式，直接从return返回的值来推断返回值类型
    (a, b) in
    return a < b
})
sortInts(&c, function: {
    //如果闭包函数中只有一条语句，那么return事可以省略的
    (a, b) in
    a < b
})
sortInts(&c, function: {
    //参数名可以省略，默认是用$0来接受第一个参数，以此类推
    $0 > $1
})
//甚至可以直接参数，而直接使用运算符来表示函数的内容
sortInts(&c, function: <)
c

//拖尾闭包， 如果最后一个参数是闭包函数，可以使用拖尾闭包，把闭包写在参数列表的后面
sortInts(&c) {
    (a : Int, b : Int) -> Bool in
    return a < b
}



//运算符重载

struct Fraction {
    var n : Int
    var m : Int
    init(n : Int, m : Int) {
        self.n = n
        self.m = m
    }
}
//加号运算符 重载
func +(f1 : Fraction, f2 : Fraction) ->Fraction {
    return Fraction(n: f1.n * f2.m + f2.n * f1.m, m: f1.m * f2.m)
}
var f1 = Fraction(n: 2, m: 3)
var f2 = Fraction(n: 3, m: 4)
var f3 = f1 + f2
















