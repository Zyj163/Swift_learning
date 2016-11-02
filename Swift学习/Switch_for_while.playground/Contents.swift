//: Playground - noun: a place where people can play

import UIKit

/*
 1.要求switch具备完整性， 要求必须有分支满足,必须找个分支进入
 2.swift中的switch没有隐式贯穿,不用加break
 3.也可以使用break,作用提前跳出
 4.如果需要继续向下贯穿，使用关键字fallthrough，显示贯穿
 */

var a = 3
switch a {
    
case 0:
    print("a=\(a)")
    
case let b where b == 3: //先用b接收a的值，然后做条件判断
    print("b==3")
    
    fallthrough

case 1...5: //case 1, 2, 3, 4, 5:
    if a == 2 {
        break
    }
    print("x > 0 && x < 6")
    
    fallthrough
    
case 1000:
    print("穿下来了")
    
//    fallthrough 下方带判断条件不能继续向下贯穿
    
case let b where b == 3: //先用b接收a的值，然后做条件判断
    print("fallthrough不能穿下来")
default:
    print("其他值")
}

//for
for i in 1...5 {
    print(i)
}

//下划线做占位符用
for _ in 1...5 {
    print("...")
}

//do...while
var aa = 2

repeat {
    aa -= 1
    print("\(aa)")
}
    while aa > 0







