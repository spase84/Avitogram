//
//  CreatePostCreatePostViewController.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 01/11/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//

import UIKit
import Toast_Swift
import SVProgressHUD
import ImageSource

class CreatePostViewController: BaseViewController {
	var presenter: CreatePostPresenterType?
	private var titleText: String = "" {
		didSet {
			navigationItem.rightBarButtonItem?.isEnabled = titleText.count > 3
		}
	}

	// MARK: Life cycle

	override func loadView() {
		view = CreatePostView(delegate: self)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		presenter?.viewIsReady()
	}

	override func setupUI() {
		super.setupUI()
		navigationItem.title = "create_post".localized.firstUppercased
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "done".localized.firstUppercased, style: .done, target: self,
																												action: #selector(doneAction))
		navigationItem.rightBarButtonItem?.isEnabled = false
		(view as? CreatePostView)?.prepareView()
	}

	// MARK: - actions

	@objc private func doneAction() {
		navigationItem.rightBarButtonItem?.isEnabled = false
		SVProgressHUD.show()
		(view as? CreatePostView)?.freeze()
		presenter?.done(title: titleText)
	}
}

extension CreatePostViewController: CreatePostViewType {
	func set(presenter: CreatePostPresenterType) {
		self.presenter = presenter
	}

	func set(image: ImageSource) {
		(view as? CreatePostView)?.set(image: image)
	}

	func show(message: String) {
		view.makeToast(message, duration: 3.0, position: .top)
	}
	
	func unfreeze() {
		SVProgressHUD.dismiss()
	}
}

extension CreatePostViewController: CreatePostViewDelegate {
	func titleUpdated(text: String) {
		titleText = text
	}
}
