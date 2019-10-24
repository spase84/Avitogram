//
//  GuestGuestPresenter.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 31/07/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//
import RxSwift

class GuestPresenter {
	private weak var view: GuestViewType?
	var navigator: GuestNavigator!
	private let disposeBag = DisposeBag()
	private let userService: UserService!
	
	init(userService: UserService) {
		self.userService = userService
	}

	// MARK: - private

	private func subscribe() {
		userService.trigger.subscribe(onNext: { status, error in
			guard nil == error else { self.handle(error: error!); return }
			switch status {
			case .authorized:
				(AppService.getAppDelegate() as? AppDelegate)?.reloadRootScreen()
			default:
				break
			}
		})
		.disposed(by: disposeBag)
	}
	
	private func handle(error: Error) {
		view?.show(message: error.localizedDescription)
	}
}

extension GuestPresenter: GuestPresenterType {
	func attach(view: GuestViewType) {
		self.view = view
	}

	func viewIsReady() {
		subscribe()
	}

	func signUp(email: String, password: String) {
		userService.sugnUp(email: email, password: password)
	}

	func signIn(email: String, password: String) {
		userService.signIn(email: email, password: password)
	}
}
