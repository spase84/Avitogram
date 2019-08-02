//
//  GuestGuestViewController.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 31/07/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//

import UIKit

class GuestViewController: UIViewController {
	private var presenter: GuestPresenterType?
	
	override func loadView() {
		view = GuestView(delegate: self)
	}
	
	// MARK: Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		presenter?.viewIsReady()
	}
}

extension GuestViewController: GuestViewType {
	func set(presenter: GuestPresenterType) {
		self.presenter = presenter
	}
}

extension GuestViewController: GuestViewDelegate {
	
}
