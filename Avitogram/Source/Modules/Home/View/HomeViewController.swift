//
//  HomeHomeViewController.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 17/10/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
	private var presenter: HomePresenterType?
	
	// MARK: Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		presenter?.viewIsReady()
	}
}

extension HomeViewController: HomeViewType {
	func set(presenter: HomePresenterType) {
		self.presenter = presenter
	}
}
