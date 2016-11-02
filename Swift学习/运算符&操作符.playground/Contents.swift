//: Playground - noun: a place where people can play

import UIKit

//=== 和 !==恒等运算符，用来比较地址

//??操作符，先对可选值进行拆包，如果不为 nil 返回操作符前面的值，如果为空返回后者。

struct Vecotor {
    var x = 0, y = 0
}


//赋值运算符＝和三目运算符不能被重载
//运算符重载
func - (left: Vecotor, right: Vecotor) -> Vecotor {
    return Vecotor(x: left.x - right.x, y: left.y - right.y)
}
//重载复合运算符
func -= (inout left: Vecotor, right: Vecotor) {
    left = left - right
}
//重载一元操作符，需要添加关键字prefix or postfix，prefix是操作符在前, postfix是操作符在后
prefix func - (vecotor: Vecotor) -> Vecotor {
    return Vecotor(x: -vecotor.x, y: -vecotor.y)
}


//自定义操作符,需要使用operator关键字。使用prefix, infix or postfix标记运算符使用的位置。
prefix operator +++ {}
prefix func +++ (vecotor: Vecotor) -> Vecotor {
    return Vecotor(x: vecotor.x + 1, y: vecotor.y + 1)
}

postfix operator +++ {}
postfix func +++ (vecotor: Vecotor) -> Vecotor {
    return Vecotor(x: vecotor.x + 2, y: vecotor.y + 2)
}

infix operator +++ {}
func +++ (left: Vecotor, right: Vecotor) -> Vecotor {
    return Vecotor(x: left.x + 3, y: right.y + 3)
}

//自定义操作符，可以定义操作符的关联性associativity和优先级precedence。associativity有三个值：left, right, none,默认是none。precedence默认值是：100。
/*
 结合性        associativity
 可取值范围    left，right和none
 
 优先级        precedence
 可取值范围    0～255
 
 系统内置运算符结合性质及优先级
 求幂相关（无结合，优先级160）
 << 按位左移（Bitwise left shift）
 >> 按位右移（Bitwise right shift）
 
 乘除法相关（左结合，优先级150）
 * 乘
 / 除
 % 求余
 &* 乘法，忽略溢出（ Multiply, ignoring overflow）
 &/ 除法，忽略溢出（Divide, ignoring overflow）       🐂  除0得0
 &% 求余, 忽略溢出（ Remainder, ignoring overflow）
 & 位与（ Bitwise AND）
 
 加减法相关（左结合, 优先级140）
 + 加
 - 减
 &+ Add with overflow
 &- Subtract with overflow
 | 按位或（Bitwise OR ）
 ^ 按位异或（Bitwise XOR）
 
 Range （无结合,优先级 135）
 .. 半闭值域 Half-closed range
 ... 全闭值域 Closed range
 
 类型转换 （无结合,优先级 132）
 is 类型检查（ type check）
 as 类型转换（ type cast）
 <= 小于等于
 >大于
 >= 大于等于
 == 等于
 != 不等
 === 恒等于
 !== 不恒等
 ~= 模式匹配（ Pattern match）
 
 合取（ Conjunctive） （左结合,优先级 120）
 && 逻辑与（Logical AND）
 
 析取（Disjunctive） （左结合,优先级 110）
 || 逻辑或（ Logical OR）
 
 三元条件（Ternary Conditional ）（右结合,优先级 100）
 ?: 三元条件 Ternary conditional
 
 赋值 （Assignment） （右结合, 优先级 90）
 = 赋值（Assign）
 *= Multiply and assign
 /= Divide and assign
 %= Remainder and assign
 += Add and assign
 -= Subtract and assign
 <<= Left bit shift and assign
 = Right bit shift and assign
 &= Bitwise AND and assign
 ^= Bitwise XOR and assign
 |= Bitwise OR and assign
 &&= Logical AND and assign
 ||= Logical OR and assign
 */
infix operator +- {associativity left precedence 140}
func +-(left: Vecotor, right: Vecotor) -> Vecotor {
    return Vecotor(x: left.x + right.x, y: left.y - right.y)
}


//example
let vecotor1 = Vecotor(x: 10, y: 15)
let vecotor2 = Vecotor(x: 5, y: 2)
let result1 = vecotor1 - vecotor2
result1.x
result1.y

let result2 = -result1
result2.x
result2.y

let result3 = result2+++
result3.x
result3.y

let result4 = result3 +- result2
result4.x
result4.y
