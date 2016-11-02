//: Playground - noun: a place where people can play

import UIKit

var dic : Dictionary<String, Int> = Dictionary<String, Int>()
var dic2 : Dictionary<String, Int> = Dictionary()
var dic3 = Dictionary<String, Int>()
var dic4 = [String : Int]()
var dic5 : [String : Int] = Dictionary()
var dic6 = ["age" : 30]

//如果字典中没有对应的key 就是增加，如果存在就是修改
var dic7 : [String : String] = Dictionary()
dic7["name"] = "jack"
dic7.updateValue("20", forKey: "age")
dic7

dic7["name"] = nil
dic7.removeValueForKey("age")
dic7

//遍历
for (ageKey, ageValue) in dic6 {
    print(ageKey, ageValue)
}

let keys = dic6.keys
let values = dic6.values

//转化为数组
let keysArr = [String](keys)
let valuesArr = [Int](values)

//swift中的字典是值类型，OC中是引用类型














