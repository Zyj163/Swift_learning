//: Playground - noun: a place where people can play

import UIKit


//: Playground - noun: a place where people can play

import UIKit


// map和 flatmap
/*
 map函数可以被数组、字典调用，他接受一个闭包作为参数，作用于数组中的每个元素。然后将所有这些被作用后的元素组成一个新的数组
 */
/*
 map函数的闭包接收一个字符串(类型为string)作为参数，因为数组元素类型为String。这里想要返回一个整型数组，逐个对应字符串元素成员的字符长度。因此闭包的返回类型为Int?.(string代表每个元素，Int？代表处理后的新元素)
 */
let testArr = ["tes", "test2", "test3"]

let newArr = testArr.map { (string: String) -> Int? in
    
    let length = string.characters.count
    
    guard length > 3 else {
        return nil
    }
    
    return length
}

//newArr中元素为可选类型
newArr

/*
 flatMap与map函数不同之处在于：倘若元素值不为nil情况下，flapMap函数能够将可选类型(optional)转换为非可选类型(non-optionals)，并且会剔除为nil的元素
 */
let anotherArray2 = testArr.flatMap {
    (string:String) -> Int? in
    
    let length = string.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
    
    guard length > 3 else {
        return nil
    }
    return length
}

//anotherArr2中元素为非可选类型
anotherArray2

//字典使用map，返回的是数组
let dict = ["1":"aa", "2":"bb"]
let newDict = dict.lazy.map { (key, value) -> String? in
    return key + value
}

newDict.first


//可选值使用,unwrapped为nil不会执行闭包
var option : String?
//option = "123"
let result = option.flatMap { (unwrapped) -> Int in
    print(unwrapped)
    let length = unwrapped.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
    
    guard length > 0 else {
        return 0
    }
    return length
}
result

let result2 = option.map { (unwrapped) -> Int in
    print(unwrapped)
    let length = unwrapped.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
    
    guard length > 0 else {
        return 0
    }
    return length
}
result2

/*
 filter用于选择数组(字典)元素中满足某种条件的元素
 */
testArr.filter { (string) -> Bool in
    return string.characters.count > 3
}



/*
 reduce方法把数组(字典)元素组合计算为一个值
 reduce(initial: U, combine: (U, T) -> U) -> U
 
 接收两个参数，一个为类型U的初始值，另一个为把类型为U的元素和类型为T的元素组合成一个类型为U的值的函数。最终结果整个数组就变成了一个类型为U的值
 */
/*
 第一个参数 ""     表示初始值，
 第二个参数 result 表示暂存的结果，
 第三个参数 string 表示数组中的某个元素，
 第四个参数 String 表示最终结果的类型
 */
testArr.reduce("") { (result, string) -> String in
    
    return string + result
}


//可以利用元祖来交换值
var y = 1
var u = 2
(y, u) = (u, y)
y
u


/*
 split(" ")按照" "分割字符串，对每个分割出来的字符创建为String
 lazy是延迟调用
 map(String.init) == map {String($0)}
 后者必须使用{}是因为调用了参数$0
 */
let s = "1 2 3 4 5"
let s2 = s.characters.split(" ").lazy.map(String.init)
let s3 = s.characters.split(" ").map {String($0)}

s2.first
s3.first

let s4 = s.characters.split(s.lengthOfBytesUsingEncoding(NSUTF8StringEncoding), allowEmptySlices: true) { (char) -> Bool in
    return char == " "
    }.map(String.init)
s4.first


//字符串中替换字符
let ss = "1?2?3?"
let ss2 = ss.stringByReplacingOccurrencesOfString("?", withString: "/", options: .LiteralSearch, range: nil)
ss2

let sss = " 123 "
//字符串中过滤字符
let ss3 = sss.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
ss3

//将数组中元素拼接为字符串
let ssss = ["1", "2", "3"]
let ss4 = ssss.joinWithSeparator("/")

//利用forEach遍历数组
var str = ""
ssss.forEach { (string) in
    str += string
}
str

//利用forEach遍历字典
let dic = ["1":"bb", "2":"bbb", "3":"bbbb"]
var arr = [String]()
dic.forEach { (key, value) in
    arr += [key]
}
arr
arr.startsWith(["2"])



//非逃逸闭包（指明闭包是在函数前执行，不能用于外部应用，另外声明了非逃逸闭包后，在闭包中不用添加self（非逃逸不存在循环引用））
//非逃逸闭包
func aaa(@noescape clo: (Void->Void)) {
    clo()
}
aaa {print("...")}

//逃逸闭包
var closure : (Void->Void)?
func bbb(clo: (Void->Void)) {
    closure = clo
}
bbb {print("...")}
closure!()


//自动闭包（自动将表达式转化为闭包，只能用于无参 ()->T ）
//自动非逃逸闭包
func ccc(@autoclosure clo: ()->Bool) {
    if clo() {
        print("...")
    }
}
ccc(2>1)

func ccc2(clo: ()->Bool) {
    if clo() {
        print("...")
    }
}
//ccc2(2>1)   ❌
ccc2 {2 > 1}


