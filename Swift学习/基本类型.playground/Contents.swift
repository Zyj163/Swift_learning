//: Playground - noun: a place where people can play

import UIKit

//swift是强类型语言，对类型检测非常严格

//类型标注
var welcomeMessage : String
//这里其实不是修改，是初始化，未初始化的值不能使用
welcomeMessage = "welcome"

//swift类型首字母大写， swift中没有基本数据类型，所谓基本数据类型都是结构体

//别名  给Float起个别名叫 MyFloat
typealias MyFloat = Float
var num : MyFloat = 0.01


//var声明的是变量，类型是根据右值推断出来的
var str = "Hello, playground"

//字面值
var x = 15 //整数的字面值默认是十进制
x = 000015 //前面的0会被忽略
x = -15
x = 1_000_000 //下划线没有实际意义，只是为了增加可读性
x = 0b00110010101 //二进制，以0b开头
x = 0o15 //八进制，以0o开头
x = 0xff //十六进制，以0x开头

var f = 3.14
f = 1.15e-2 //e-2相当于10的-2次方
f = 1.15 * 0.01


//swift中可以对浮点型取余
var ff = f % 2.1
ff = 24 % 2.4
ff = f % 2

//三目
var y : Int?
y = ff < 1.0 ? 1 : 0

//空合
//如果为真 返回y， 否则返回0
y = y ?? 0

//区间运算符
1...5 //包括1 包括5
1..<5 //包括1 不包括5
for i in 1...5 {
    print(i)
}
