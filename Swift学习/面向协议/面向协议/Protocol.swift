//
//  Protocol.swift
//  面向协议
//
//  Created by ddn on 2017/4/26.
//  Copyright © 2017年 张永俊. All rights reserved.
//

import UIKit

/*
默认情况下协议中定义的是必须实现的
*/
//遵守该协议的可以是类／结构体／枚举
protocol AnyProtocol {
	//由遵守协议者来确定具体类型
	associatedtype Data
	
	var data: Data {get set}
}

//遵守该协议的只能是类，这种协议delegate才能用weak修饰
protocol ClassProtocol: class {}

/*
如此实现可选实现
*/
@objc protocol OptionalProtocol {
	@objc optional func optionalPlay()
	@objc optional var price: Double {get set}
}

//默认实现，被实现后会被覆盖(可以通过where添加限制条件, 怎么加多个限制条件？)
extension AnyProtocol where Self: UIView {
	
	//类方法
	static func loadFromNid(_ nibName: String? = nil) -> Self {
		return Bundle.main.loadNibNamed(nibName ?? "\(self)", owner: nil, options: nil) as! Self
	}
}

extension UITableView {
	
	func registerCell<T: UITableViewCell>(_ cell: T.Type) where T: AnyProtocol {
		print("amazing")
	}
}

extension AnyProtocol {
	//属性默认实现只能以计算属性的形式实现
	var price: Double {
		return 100
	}
	
	func play() {
		print("play")
	}
	
	func sing() {
		print("sing")
	}
	
	static func run() {
		print("run")
	}
}





