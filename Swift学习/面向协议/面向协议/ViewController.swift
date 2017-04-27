//
//  ViewController.swift
//  面向协议
//
//  Created by ddn on 2017/4/26.
//  Copyright © 2017年 张永俊. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AnyProtocol, ClassProtocol {
	typealias Data = [String]
	var data: [String]

	//所有属性必须在init之前初始化
	init() {
		self.data = [String]()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
//	weak var delegate: AnyProtocol?  //❌
	weak var delegate: ClassProtocol?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		play()
		sing()
		
		ViewController.run()
	}

	func play() {
		print("pp")
	}
}

  
