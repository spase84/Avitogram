//
//  HomeHomeViewController.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 17/10/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//

import UIKit
import Paparazzo
import ImageSource

class HomeViewController: BaseViewController {
	private var presenter: HomePresenterType?
	
	// MARK: Life cycle

	override func loadView() {
		view = HomeView(delegate: self)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		(view as? HomeView)?.prepareView()
		setupNavigationBar()
		presenter?.viewIsReady()
	}

	// MARK: - private

	private func setupNavigationBar() {
		navigationItem.title = "home".localized.firstUppercased
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "sign_out".localized.firstUppercased, style: .plain, target: self,
																											 action: #selector(signoutAction))
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
	}
	
	private func showPicker() {
		let viewController = PaparazzoFacade.paparazzoViewController(
			theme: PaparazzoUITheme(),
			parameters: MediaPickerData(
				items: [],
				maxItemsCount: 1
			),
			onFinish: { images in
				guard let image = images.first?.image else { return }
				image.fullResolutionImageData { data in
					guard let imgData = data else { return }
					self.presenter?.imagePicked(data: imgData)
				}
			}
		)

		self.present(viewController, animated: true, completion: nil)
	}

	// MARK: - actions

	@objc private func signoutAction() {
		let alert = UIAlertController(title: "sign_out".localized.firstUppercased, message: "sign_out_confirmation".localized.firstUppercased,
																	preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "sign_out".localized.firstUppercased, style: .destructive, handler: { _ in
			self.presenter?.signOut()
		}))
		alert.addAction(UIAlertAction(title: "cancel".localized.firstUppercased, style: .cancel, handler: nil))
		present(alert, animated: true, completion: nil)
	}

	@objc private func addAction() {
		showPicker()
	}
}

extension HomeViewController: HomeViewType {
	func set(presenter: HomePresenterType) {
		self.presenter = presenter
	}

	func update(collection: [Post]) {
		(view as? HomeView)?.update(collection: collection)
	}
}

extension HomeViewController: HomeViewDelegate {}
