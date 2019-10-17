//
//  GuestGuestViewController.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 31/07/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//

import UIKit
import Toast_Swift

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
	func signUpEvent(email: String, password: String) {
		presenter?.signUp(email: email, password: password)
	}
	
	func signInEvent(email: String, password: String) {
		presenter?.signIn(email: email, password: password)
	}
	
	func show(message: String) {
		view.makeToast(message, duration: 3.0, position: .top)
	}
}
