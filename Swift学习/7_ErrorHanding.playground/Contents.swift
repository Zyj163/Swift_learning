//: Playground - noun: a place where people can play

import UIKit

//swift中 错误用符合 ErrorType 协议的值， 创用枚举把一系列相关的错误组合在一起

enum VendingMachineError : ErrorType {
    case InvalidSelection //没有找到相关物品
    case InsufficientFunds(required : Double) //钱不够
    case OutOfStock //数量不够
}

struct Item {
    var price : Double
    var count : Int
}
//商店库存
var inventory = ["口香糖":Item(price: 1.25, count: 7), "可乐":Item(price: 1.00, count: 5),"饼干":Item(price: 0.75, count: 3)]
var amountDeposited = 1.00 //拥有的现金

//该方法可能会抛出错误，必须标注 throws
func vend(name : String) throws {
    guard var item = inventory[name] else {
        //抛出没有找到 该物品的错误
        throw VendingMachineError.InvalidSelection
    }
    guard item.count > 0 else {
        //抛出错误 东西卖完了
        throw VendingMachineError.OutOfStock
    }
    guard amountDeposited > item.price else {
        //抛出错误 钱不够  并关联 需要多少钱
        throw VendingMachineError.InsufficientFunds(required: item.price - amountDeposited)
    }
    amountDeposited -= item.price
    item.count -= 1
    inventory[name] = item
}

amountDeposited = 0.1
do{
    try vend("饼干2")
}catch VendingMachineError.InvalidSelection {
    print("没有找到 要买的物品")
}catch VendingMachineError.OutOfStock {
    print("数量不够")
}catch VendingMachineError.InsufficientFunds(let amountRequired) {
    print("钱不够 还需要\(amountRequired)")
}
var a = 10

amountDeposited = 10
func test() throws {
    //将异常抛给 上层函数出来
    try vend("饼干2")
}

do {
    try test()
}catch {
    print("方法有异常")
}














