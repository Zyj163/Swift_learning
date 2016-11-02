//: Playground - noun: a place where people can play

import UIKit

//元组  是一个将多个类型相同或不同的元素组合成一个数据的形式
//一个元组中可以有两个及以上的元素,而且元素类型可以不同

var _404error = (404, "not found")
var _404error2 : (Int , String) = (404, "not found")

//访问元祖元素(值类型)
var (status, des) = _404error
status
des

var (sta, _) = _404error
sta

_404error.0 = 505
_404error.1
sta

//添加别名，提高可读性(0,1还可以用)
var _505error = (code : 505, des : "unknown")
_505error.0
_505error.code
_505error.des


//example
let onePoint = (10, 0)

switch onePoint {
case (0, 0):
    print("点在 原点 上")
case (_, 0):
    print("点在x轴上")
case (0, _):
    print("点在y轴上")
case (-2...2, -3...3):
    print("点在矩型内")
default:
    print("不在规定范围内")
}


var anotherPoint = (100, 0)
switch anotherPoint {
case (0, 0):
    print("点在 原点 上")
case (let x, 0):
    print("点在x轴上, 当前的x是 \(x)")
case (0, let y):
    print("点在y轴上, 当前的x是 \(y)")
case (-2...2, -3...3):
    print("点在矩型内")
default:
    print("不在规定范围内")
}

anotherPoint = (-5, 5)
switch anotherPoint {
case (let x, let y) where x == y:
    print("点在1 斜线上")
case (let x, let y) where x == -y:
    print("点在2 斜线上")
default:
    print("不在规定范围内")
}
























