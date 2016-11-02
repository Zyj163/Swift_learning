//: Playground - noun: a place where people can play

import UIKit

//新增功能
//带标签的语句
var a = 0
loop : while a < 100 {
    a += 1
    switch a {
    case 20:
        break loop //跳出标签的地方
    default:
        print(a)
    }
}

loop : for i in 1...10 {
    for j in 1...10 {
        if j == 3 {
            continue loop
        }
        print(j)
    }
}

func greet(person : [String : String]) {
    //person["name"] 从字典中通过key 取 对应的value, 如果没有找到对应key，那么返回一个nil
    //如果 guard 后面语句为真,代码跳过else继续向下执行, 否则 进入else代码块
    guard let name = person["name"] else {
        print("没有找到对应的key")
        return
    }
    print(name)
}
greet(["n" : "joke"])
greet(["name" : "joke"])






