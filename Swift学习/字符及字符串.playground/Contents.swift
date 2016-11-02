//: Playground - noun: a place where people can play

import UIKit


var str : String
//变量不初始化不能使用
//print(str)

str = ""
if str.isEmpty {
    print("空字符串")
}

var str2 : String = String()
if str2.isEmpty {
    print("空字符串")
}

//值类型、引用类型（指针）
//swift所有结构体都是值类型，所有class都是引用类型，OC中所有类在swift都是引用类型
var str3 = "hello"
var str4 = str3 //相当于赋值，开辟新内存
str3.appendContentsOf("你好")
str3
str4

var str5 : NSMutableString = "hello"
var str6 : NSMutableString
str6 = str5 //相当于传递指针，没有开辟新内存
str5.appendString("你好")
str5
str6


//字符，在声明的时候需要指明Character，否则会被推断为字符串
var ch : Character = "a"

//swift 中的编码 UNICODE 包括 中文 日文 韩文 阿拉伯文 特殊字符 等等
ch = "中"
ch = "😟"
ch
var 中国 = "china"
中国
var 🐶 = "dog"


//拼接
var st = "it"
var chh : Character = " "
var st2 = "is"
var new = st + String(chh) + st2


//字符数组
var chs : [Character] = ["c", "a", "!"]

//转换字符数组为字符串
var chsToStr = String(chs)

for char in chsToStr.characters {
    print(char)
}

//类型转换
var st3 : NSString = "123"
var st4 : String = st3 as String

//因为可以通过一个String变量创建一个NSString对象,String转换到NSString可以直接转换
var st5 : NSString = st4





