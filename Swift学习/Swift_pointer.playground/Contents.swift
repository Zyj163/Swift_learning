//: Playground - noun: a place where people can play

//参考http://www.jb51.net/article/103538.htm
import UIKit

//Memory Layout 检测特定类型的大小
//size 除对齐字节外的所有字节
//alignment 对齐字节数
//stride 实际所占字节数，包括alignment

/**---基本类型(swift中其实没有基本类型，比如Int其实是结构体)----*/
MemoryLayout<Bool>.size // return 1
MemoryLayout<Bool>.alignment // return 1
MemoryLayout<Bool>.stride // return 1

MemoryLayout<Int8>.size // return 1
MemoryLayout<Int8>.alignment // return 1
MemoryLayout<Int8>.stride // return 1

MemoryLayout<Int16>.size // return 2
MemoryLayout<Int16>.alignment // return 2
MemoryLayout<Int16>.stride // return 2

MemoryLayout<Int32>.size
MemoryLayout<Int64>.size

MemoryLayout<Int>.size // return 8 (on 64-bit)
MemoryLayout<Int>.alignment // return 8 (on 64-bit)
MemoryLayout<Int>.stride // return 8 (on 64-bit)

MemoryLayout<Float>.size // return 4
MemoryLayout<Float>.size // return 4
MemoryLayout<Float>.alignment // return 4

MemoryLayout<Double>.stride // return 8
MemoryLayout<Double>.alignment // return 8
MemoryLayout<Double>.stride // return 8
/**------------------------------------------------*/

/**------------------结构体----------------------*/
struct EmptyStruct {}
//空结构体的大小为 0，内存对齐为 1， 表明它可以存在于任何一个内存地址上。有趣的是 stride 为 1，这是因为尽管结构为空，但是当我们使用它创建一个实例的时候，它也必须要有一个唯一的地址。
MemoryLayout<EmptyStruct>.size
MemoryLayout<EmptyStruct>.alignment
MemoryLayout<EmptyStruct>.stride

MemoryLayout<String>.size
MemoryLayout<String>.alignment
MemoryLayout<String>.stride
//size为25，stride为32，因为String内存对齐为8，Int8内存对齐为1，所以结构体的内存对齐为8，所以stride = MemoryLayout<String>.stride + MemoryLayout<Int8>.stride = 32, size = MemoryLayout<String>.size + MemoryLayout<Int8>.size = 25，如果交换name和number的顺序，由于内存对齐size = MemoryLayout<String>.size + MemoryLayout<Int8>.size + MemoryLayout<SampleStruce>.alignment
struct SampleStruce {
    let name: String
    var number: Int8
}
MemoryLayout<SampleStruce>.size
MemoryLayout<SampleStruce>.alignment
MemoryLayout<SampleStruce>.stride
/**------------------------------------------------*/

/**-------------------类-----------------------*/
//由于类属于引用类型，所以固定是8
class EmptyClass {}
MemoryLayout<EmptyClass>.size
MemoryLayout<EmptyClass>.alignment
MemoryLayout<EmptyClass>.stride

class SampleClass {
    let name: String = ""
    let number: Int8 = 0
}
MemoryLayout<SampleClass>.size
MemoryLayout<SampleClass>.alignment
MemoryLayout<SampleClass>.stride
/**------------------------------------------------*/

/**-----------------可选类型--------------------*/
//类仍然固定是8
MemoryLayout<SampleClass?>.size
MemoryLayout<SampleClass?>.alignment
MemoryLayout<SampleClass?>.stride

//size会比非可选类型+1，对于基本类型stride += 1 * alignment，对一个字节，但是内存对齐的原因，会增加alignment
MemoryLayout<Int8?>.size
MemoryLayout<Int8?>.alignment
MemoryLayout<Int8?>.stride

MemoryLayout<String?>.size
MemoryLayout<String?>.alignment
MemoryLayout<String?>.stride

//因为alignment为8，Int8排布在后面，会空余7，所以多出一字节会直接拼到后面，size += 1, stride = stride，如果Int8在String前面stride += 1 * alignment
MemoryLayout<SampleStruce?>.size
MemoryLayout<SampleStruce?>.alignment
MemoryLayout<SampleStruce?>.stride
/**------------------------------------------------*/

/**----------------------swift中的指针---------------
 不可变类型没有allocate和deallocate
UnsafeMutablePointer<T>  //有类型的可变的，对应于C语言中的T *
UnsafePointer<T> //有类型的不可变的，对应于C语言中的const T *
 
UnsafeMutableBufferPointer<T> //缓冲的有类型的可变的
UnsafeBufferPointer<T>  //缓冲的有类型的不可变的
 
UnsafeMutableRawPointer  //原生类型的可变的，对应于C语言中的void *
UnsafeRowPointer  //原生类型的不可变的，对应于C语言中的const void *
 
UnsafeMutableRawBufferPointer  //缓冲的原生类型的可变的
UnsafeRawBufferPointer  //缓冲的原生类型的不可变的
------------------------------------------------*/

/**-----------------原生raw指针------------------*/
let count = 4
let stride = MemoryLayout<Int>.stride
let alignment = MemoryLayout<Int>.alignment
let totalBytes = stride * count

//使用do来添加一个作用域
do {
    //创建一个Int类型的指针，该指针指向的区域包含两个Int类型的数据，bytes = Int.stride * count, alignedTo = Int.alignment
    let pointer = UnsafeMutableRawPointer.allocate(bytes: totalBytes, alignedTo: alignment)
    
    //使用defer在退出do作用域的时候释放指针，指针操作开辟空间和释放空间需要手动管理
    defer {
        pointer.deallocate(bytes: totalBytes, alignedTo: alignment)
    }
    
    //存储数据(后三行的操作是一样的)
    pointer.storeBytes(of: 100, as: Int.self)
    pointer.advanced(by: stride).storeBytes(of: 200, as: Int.self)
    pointer.storeBytes(of: 10, toByteOffset: stride * 2, as: Int.self)
    (pointer + stride * 3).storeBytes(of: 20, as: Int.self)
    
    //加载数据(后三行的操作是一样的)
    pointer.load(as: Int.self)
    pointer.advanced(by: stride).load(as: Int.self)
    pointer.load(fromByteOffset: stride * 2, as: Int.self)
    (pointer + stride * 3).load(as: Int.self)
    
    //以buffer（一系列字节）的形式来读取数据，此处以一字节为单位
    let bufferPointer = UnsafeRawBufferPointer(start: pointer, count: totalBytes)
    for (index, byte) in bufferPointer.enumerated() {
        print("原生指针---" + "\(index) : \(byte)")
    }
    
    //如何改变为8个字节或其他单位？？？---->用类型指针
    
    /**---------------将原生指针转换为类型指针-----------------*/
    let typedPointer = pointer.bindMemory(to: Int.self, capacity: count)
    //这里不需要initialize，因为pointer已经存储了数据，initialize会覆盖之前的数据
//    typedPointer.initialize(to: count)
    defer {
        typedPointer.deinitialize(count: count)
        //这里不能调用deallocate，因为实际内存就是pointer指向的内存，pointer已经做了deallocate工作，这里不能在重复操作
//        typedPointer.deallocate(capacity: count)  ❌
    }
    let typeBufferPointer = UnsafeBufferPointer(start: typedPointer, count: count)
    for (index, pointee) in typeBufferPointer.enumerated() {
        print("原生指针--->类型指针---" + "\(index) : \(pointee)")
    }
    /**------------------------------------------------*/
}
/**------------------------------------------------*/

/**---------------------类型指针--------------------*/
do {
    //类型指针不需要指定总字节数和对齐字节数，但是需要指定泛型参数及个数
    let pointer = UnsafeMutablePointer<Int>.allocate(capacity: count)
    //在使用类型指针前需要对其进行初始化，并在使用后销毁。这两个功能分别是使用 initialize 和 deinitialize 方法
    pointer.initialize(to: 0)
    
    defer {
        pointer.deinitialize(count: count)
        pointer.deallocate(capacity: count)
    }
    
    pointer.pointee = 100
    pointer.advanced(by: 1).pointee = 200
    (pointer + 2).pointee = 10
    (pointer + 3).pointee = 20
    
    pointer.pointee
    pointer.advanced(by: 1).pointee
    (pointer + 2).pointee
    (pointer + 3).pointee
    
    //有类型的缓冲型指针也会直接操作数值，而非字节
    let bufferPointer = UnsafeMutableBufferPointer<Int>(start: pointer, count: count)
    for (index, pointee) in bufferPointer.enumerated() {
        print("类型指针---" + "\(index) : \(pointee)")
    }
}
/**------------------------------------------------*/

/**------------获取一个实例的字节---------------*/
do {
    var sampleStruct = SampleStruce(name: "垃圾", number: 11)
    
    //不要从 withUnsafeBytes 中返回指针，因为不知道这个指针会在什么时候释放，不安全
    withUnsafeBytes(of: &sampleStruct, { (rawBufferPointer) -> Void in
        for (index, byte) in rawBufferPointer.enumerated() {
            print("实例--->原生buffer指针---" + "\(index) : \(byte)")
        }
    })
    withUnsafePointer(to: &sampleStruct, { (pointer) -> Void in
        print("实例--->类型指针---: \(pointer.pointee)") //sampleStruct
        
        /**------------重新绑定类型---------------*/
        pointer.withMemoryRebound(to: String.self, capacity: 2, { (stringPointer) -> Void in
            print("实例--->类型指针--->重新绑定为String类型指针: \(stringPointer.pointee)") //name
            stringPointer.advanced(by: 1).withMemoryRebound(to: Int8.self, capacity: 1, { (int8Pointer) -> Void in
                print("实例--->类型指针--->重新绑定为String类型指针--->重新绑定为Int8类型指针: \(int8Pointer.pointee)") //number
            })
            /**-----------强制转换指针类型------------*/
            let int8Pointer = unsafeBitCast(stringPointer.advanced(by: 1), to: UnsafePointer<Int8>.self)
            print("实例--->类型指针--->重新绑定为String类型指针--->强转为Int8类型指针: \(int8Pointer.pointee)") //number
            /**------------------------------------*/
        })
        /**------------------------------------------------*/
    })
    print("实例--->可变类型指针前--\(sampleStruct)")
    withUnsafeMutablePointer(to: &sampleStruct, { (mpointer) -> Void in
        mpointer.pointee.number = 22
    })
    print("实例--->可变类型指针后--\(sampleStruct)")
}
/**------------------------------------------------*/

func getPointer(point: UnsafeMutablePointer<Int>) {
//    print(point.pointee)
}
var toGetPoint: Int = 1
getPointer(point: &toGetPoint)

//let _ = &toGetPoint //❌ 不能用这种方式获取指针，&toGetPoint只能当做函数参数传递指针


/**----------------将一个指针指向的内存强制按位转换为目标的类型-----------------*/
let a: [Int] = [97, 98, 99]
let bitCast = unsafeBitCast(a, to: [Character].self)
print(bitCast)
/**----------------------------------------------------------------*/
