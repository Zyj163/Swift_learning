//: Playground - noun: a place where people can play

import UIKit

//创建数组
//标准写法
var array : Array<Int> = Array<Int>()
array = [0, 1, 2]
array.append(200)
//array.append("123")//泛型是Int类型，就只能放Int的元素

//简单写法
var array2 = Array<Int>()
var array3 : Array<Int> = Array()
var array4 : [Int] = Array()
var array5 = [Int]()
var array6 = [1, 2]
array6 = []//元素类型已经确定为整型
//var array7 = []//数组元素类型必须要确定

var list = [1, 2, 3]
//数组常用操作--增、删、改、查
//增
list.append(4)
list += [5]
list += [6, 7]
list.insert(0, atIndex: 0)

//删
var number = list.removeAtIndex(0)
list.removeFirst()
list.removeLast()
list.removeRange(0..<2)
//参数是true 删除所有元素，并且保存容量，表示内存中依然存在
//参数是flase 删除所有元素，并且不保存容量，是把数组从内存中删除
//list.removeAll(keepCapacity: true)

//改
list.replaceRange(0..<2, with: [0, 1])
list[0] = -1

//查
var subList = list[0...1]
list.contains(-1)

//遍历
for num in list {
    print(num)
}

for (index, num) in list.enumerate() {
    print("\(index), \(num)")
}

for i in 0..<list.count {
    print(i)
}


//swift中array是值类型，OC是引用类型
var view = UIView()
var view2 : UIView? = UIView()//有一个元素是可选值类型，则推断数组中其他元素也为可选值
var arr = [view, view2]
var arr2 = arr

arr[0] = nil
arr
arr2

//创建数组对象  指定元素个数 并给每个元素进行初始化
var threeInt = [Int](count: 3, repeatedValue: 100)
threeInt
var threeInt2 = Array<Int>(count: 3, repeatedValue: 200)

threeInt += threeInt2
threeInt.count
var threeInt3 = Array(count: 3, repeatedValue: "abc")
//数组可以相加，但是类型要相同
//threeInt += threeInt3


let n = 5
//表示 二维数组
var nine = [[Int]](count: n, repeatedValue: [Int](count: n, repeatedValue: 0))































