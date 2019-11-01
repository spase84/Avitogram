//
//  BaseViewController.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 23.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import UIKit

public class BaseViewController: UIViewController {

	convenience init() {
		self.init(nibName: nil, bundle: nil)
	}

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override public var preferredStatusBarStyle: UIStatusBarStyle {
		return .default
	}

// ------ setup ui -------
	public override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		self.setupUI()
	}

	internal func setupUI() {	}
}
