//
//  UserService.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 07.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

enum AuthStatus {
	case guest, authorized
}

protocol UserService {
	var trigger: PublishSubject<(AuthStatus, Error?)> { get }
	static var currentUser: User { get }
	func signIn(email: String, password: String)
	func sugnUp(email: String, password: String)
	func signOut()
}

final class UserServiceImpl: UserService {
	private(set) var trigger: PublishSubject<(AuthStatus, Error?)> = PublishSubject<(AuthStatus, Error?)>()
	private let firebaseAuth = Auth.auth()
	static var currentUser: User {
		var user = User()
		if let firUser = Auth.auth().currentUser {
			user.id = firUser.uid
			user.name = firUser.displayName
		}
		return user
	}

	func signIn(email: String, password: String) {
		firebaseAuth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
			if let error = error {
				self?.trigger.onNext((.guest, error))
			} else {
				switch authResult {
				case .some:
					self?.trigger.onNext((.authorized, nil))
				default:
					break
				}
			}
		}
	}
	
	func sugnUp(email: String, password: String) {
		firebaseAuth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
			if let error = error {
				self?.trigger.onNext((.guest, error))
			} else {
				switch authResult {
				case .some:
					self?.trigger.onNext((.authorized, nil))
				default:
					break
				}
			}
		}
	}
	
	func signOut() {
		do {
			try firebaseAuth.signOut()
		} catch let signOutError as NSError {
			debugPrint("Error signing out: %@", signOutError.localizedDescription)
		}
	}
}
