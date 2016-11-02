//: Playground - noun: a place where people can play

import UIKit

//泛型  是 类型参数化技术  T这个类型参数的类型是推断出来的
func swapTow<T>(inout a : T, inout b : T ) {
    let n = a
    a = b
    b = n
}
var a = 10
var b = 20
swapTow(&a, b: &b)
a
b

//把处理的 类型 提取出来 作为参数
struct Stack<T>{
    private var items = [T]()
    mutating func push(item : T) {
        items.append(item)
    }
    mutating func pop() ->T {
        return items.removeLast()
    }
}
var intStack = Stack<Int>()
intStack.push(100)
var stack = Stack<String>()
stack.push("abc")
var stack2 : Stack<Double> = Stack()

















