//
//  ViewController.swift
//  Collection协议
//
//  Created by ddn on 16/11/14.
//  Copyright © 2016年 张永俊. All rights reserved.
//
//http://mp.weixin.qq.com/s?__biz=MzI4NjAzODk0OQ==&mid=2652684784&idx=1&sn=e520440c3024f1e1180203b69e05b192&chksm=f00b6f3ac77ce62c5ff56198fa7479d319984319b13b34b8595a0f208ee63e6aafca70627ee0&scene=0#wechat_redirect
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    fileprivate func testInterator() {
        let num = [1, 2, 3, 4]
        var interator = num.makeIterator()
        /// - Returns: The next element in the underlying sequence if a next element
        ///   exists; otherwise, `nil`.
        while let n = interator.next() {
            print(n)
        }
    }

}

extension Collection {
    
}

//Collection相关协议
//associatedtype Iterator: IteratorProtocol = IndexingIterator<Self>
//迭代器 Iterator
/*
 Sequence 通过创建迭代器来访问它们的元素。迭代器每次产生一个序列的值next()，并在遍历该序列时追踪它的迭代状态。
 迭代器(IteratorProtocol)内部有一个称为 Element 的关联类型。Element 类型指定了迭代器的生成值类型。迭代器也定义了它的 Sequence 的 Element 类型.
 集合的默认迭代器类型是 IndexingIterator \。这是一个非常简单的封装结构体，它使用集合自身的索引来遍历每个元素。
 */
