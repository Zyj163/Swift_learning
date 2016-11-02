//: Playground - noun: a place where people can play

import UIKit

//set 集合中相同的元素只有一个

//OC中的 Set
var nsSet = NSSet()

//swift
var letters : Set<Character> = Set<Character>()
letters.insert("a")
letters.insert("b")
letters.insert("c")
letters

letters = []
letters.insert("f")

//通过数组来创建集合
var favoriteGenres : Set<String> = ["Rock", "Classical", "Jazz", "Hippop"]
favoriteGenres
//通过数组中元素类型 推断出 集合的泛型
var favoriteGenres2 : Set = ["Rock", "Classical", "Jazz", "Hippop"]
favoriteGenres.isEmpty
favoriteGenres.count


if let remove = favoriteGenres.remove("Rock2") {
    print("成功移除 \(remove)")
}else {
    print("没有找到要移除的元素")
}
favoriteGenres.count

//一个集合中是否包含了某个元素
favoriteGenres.contains("Rock")

for genre in favoriteGenres {
    print("元素是 \(genre)")
}
print("=================")
favoriteGenres.insert("abc")
favoriteGenres.insert("Wzbc")
favoriteGenres.insert("wzbc")

//排序从小到大排序  如果是字符串先排大写  再排小写
for genre in favoriteGenres.sort() {
    print("元素是 \(genre)")
}



let oddDigits : Set = [1, 3, 5, 7, 9]
let evenDigits : Set = [0, 2, 4, 6, 8]
//并集 返回一个新的集合
print("\(oddDigits.union(evenDigits))")
//交集
print("\(oddDigits.intersect(evenDigits))")

var singleDigitPrimeNumbers : Set = [2, 3, 5, 7]
//根据不在该集合中的值创建一个新的集合
oddDigits.subtract(singleDigitPrimeNumbers)
// 1 3 5 7 9
// 2 3 5 7
//两个集合，全集减去交集的元素组成新的集合
oddDigits.exclusiveOr(singleDigitPrimeNumbers)


var houseAnimals : Set = ["a", "b"]
var farmAnimals : Set = ["a", "b", "c"]
//该集合中的所有元素，是否在另一个集合全部都有
houseAnimals.isSubsetOf(farmAnimals)
//判断一个集市是否是该集合的子集
farmAnimals.isSupersetOf(houseAnimals)
//判断两个集合 是否 不含有相同的元素
var farmAnimals2 : Set = ["c", "d"]
houseAnimals.isDisjointWith(farmAnimals2)
