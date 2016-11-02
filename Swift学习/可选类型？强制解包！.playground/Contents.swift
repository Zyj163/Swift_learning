//: Playground - noun: a place where people can play

import UIKit


//可选值类型 (optionals) 用来处理值可能缺省的情况(就是值有可能是空的 也就是说有可能 nil)
var x : Int? //不是没有初始化，而是可选址默认使用nil进行初始化
print("x = \(x)")

//<>泛型  类型参数化技术
var o : Optional<Int>
var o2 : Int?

//非可选值，不能为nil
var a : Int = 10
//a = nil


var y2 : Int?
y2 = 100
//可选值 外面有个包， 使用可选值的时候需要解包使用，可以使用 ! 在可选值后面解包
//y2 += 1
y2! += 1

//可选绑定
//如果 Int("123") 的结果不是nil，赋值num并解包（自动解包）, 如果 Int("abc") 是nil，那么直接进入else代码块
if let num = Int("123") {
    print("转换成功 num = \(num)")
}else {
    print("转换失败")
}

if let nn : Int? = 2 {
    print("...")
}

//强制解包 和 普通 可选值类型
var view : UIView? //普通的可选值类型
view = UIView()
view = nil
//可选连  如果某个链子是nil，不在处理，直接向下执行代码
view?.description

var view2 : UIView! //强制解包的可选值类型
view2 = UIView()
view2 = nil
view2?.description
//view2.description





































