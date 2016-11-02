//: Playground - noun: a place where people can play

import UIKit

enum CompassPoint {
    case North
    case South
    case East
    case West
}
var point : CompassPoint
point = CompassPoint.North
point = .North// 通过上下文环境，找到对应的枚举
//point = 0 和C中不一样，不能直接用Int赋值

point = .South
switch point {
case CompassPoint.North:
    print("北边")
case .South:
    print("南边")
case .East:
    print("东边")
case .West:
    print("西边")
}


enum Planet {
    //在一行中声明多个枚举值
    case Mercury, Venus, Earth, Jupiter
}
Planet.Mercury

//如果我们希望 swift 中的枚举可以和 C中的使用一样， 每个枚举值对应有一个Int类型值
//枚举的原始值 (裸值)
//枚举在创建的时候，每个元素可以给一个裸值
enum Week : Int {
    case Sun = 0, Mon, Tur, Wen, Thu, Fri, Sat //递增+1
}
var weekDay : Week = Week.Sun
//weekDay.rawValue 获取枚举中的裸值
var weekNum : Int = weekDay.rawValue

//通过裸值 创建 枚举变量
var fri : Week? = Week(rawValue: 5)



//枚举的关联值
enum Barcode {
    //条行码
    case UPCA(Int,Int,Int)
    //二维码
    case QRCode(String)
    case UnknowCode
    
    var string: String? {
        var result: String?
        switch self {
            //想怎么写怎么写
        //case let .UPCA(num, id, check):
        //case .UPCA(let num, let id, var check):
        case .UPCA(let(num, id, check)):
            result = "这是一个条形码 \(num) - \(id) - \(check)"
        case .QRCode(let pCode):
            result = "这是一个二维码 \(pCode)"
        case .UnknowCode:
            result = nil
        }
        return result
    }
}
//69表示中国  商品分类等  校验码(固定算法)
var upca : Barcode = Barcode.UPCA(69, 2425468919, 1)
var qrcode : Barcode = Barcode.QRCode("sdfkjsldkfj")
var unknow: Barcode = Barcode.UnknowCode

upca.string
qrcode.string
unknow.string


//if case
if case Barcode.UnknowCode = unknow {
    print("...")
}else {
    print("---")
}

//guard case
guard case Barcode.QRCode(let code) = qrcode else {
    fatalError()
}
print(code)


let foo = "abcdef".characters
let bar = "abcdefghij".characters
//successor()代表下一个
guard case foo.indices = bar.startIndex.successor().successor().successor().successor().successor() else {
    fatalError()
}
//predecessor()代表上一个
guard foo.indices ~= bar.endIndex.predecessor().predecessor().predecessor().predecessor().predecessor() else {
    fatalError()
}
print("---")

foo.indices
bar.endIndex.predecessor().predecessor().predecessor().predecessor().predecessor()




