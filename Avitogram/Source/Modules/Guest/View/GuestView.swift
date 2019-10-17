//
//  GuestView.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 31.07.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import UIKit
import EasyPeasy
import RxSwift
import RxCocoa

protocol GuestViewDelegate: class {
	func signUpEvent(email: String, password: String)
	func signInEvent(email: String, password: String)
}

class GuestView: UIView {
	private weak var delegate: GuestViewDelegate?
	private let disposeBag = DisposeBag()

	// subviews
	private let scrollView = UIScrollView()
	private let contentView = UIView()
	private let signInButton: UIButton = {
		let btn = MPRoundedButton(radius: 5, backgroundColor: .SLDullYellow, textColor: .black)
		btn.setTitle("sign in".localized.firstUppercased, for: .normal)
		btn.isEnabled = false
		return btn
	}()
	private let signUpButton: UIButton = {
		let btn = UIButton()
		btn.setTitle("sign up".localized.firstUppercased, for: .normal)
		btn.setTitleColor(.SLDullYellow, for: .normal)
		btn.setTitleColor(.gray, for: .disabled)
		btn.isEnabled = false
		return btn
	}()
	private let orLabel: UILabel = {
		let label = UILabel()
		label.textColor = .SLWhite
		label.font = .systemFont(ofSize: 15)
		label.text = "or".localized
		label.textAlignment = .center
		return label
	}()
	private let emailField: UITextField = {
		let field = UITextField(padding: 10)
		field.keyboardType = .emailAddress
		field.autocapitalizationType = .none
		field.attributedPlaceholder = "email".localized.firstUppercased.attributed(attributes: Settings.shared.placeholderAttrs)
		field.backgroundColor = .SLBlackTwo
		field.layer.cornerRadius = 6
		field.clipsToBounds = true
		field.keyboardAppearance = .dark
		field.textColor = .SLWhite
		field.returnKeyType = .next
		return field
	}()
	private let passwordField: UITextField = {
		let field = UITextField(padding: 10)
		field.isSecureTextEntry = true
		field.backgroundColor = .SLBlackTwo
		field.attributedPlaceholder = "password".localized.firstUppercased.attributed(attributes: Settings.shared.placeholderAttrs)
		field.layer.cornerRadius = 6
		field.clipsToBounds = true
		field.keyboardAppearance = .dark
		field.textColor = .SLWhite
		field.returnKeyType = .done
		return field
	}()
	
	// MARK: initialization
	init(delegate: GuestViewDelegate) {
		super.init(frame: .zero)
		self.delegate = delegate
		setupUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	// MARK: - private
	
	private func setupUI() {
		self.backgroundColor = .SLBlack
		setupScrollView()
		setupSignInForm()
		setupSignInButton()
		setupOrLabel()
		setupSignUpButton()
		setupTapGesture()
		bindUI()
	}
	
	private func bindUI() {
		let isValidPassword = passwordField.rx.text.orEmpty
			.map { $0.count > Settings.shared.passwordMinLength }
			.distinctUntilChanged()

		let isValidEmail = emailField.rx.text.orEmpty
			.map { $0.isValidEmail }
			.distinctUntilChanged()

		Observable.combineLatest(isValidEmail, isValidPassword) { $0 && $1 }
			.subscribe(onNext: { isValidCredentials in
				self.signInButton.isEnabled = isValidCredentials
				self.signUpButton.isEnabled = isValidCredentials
			}).disposed(by: disposeBag)

		let emailOnNext = emailField.rx.controlEvent([.editingDidEndOnExit])
			.subscribe(onNext: { _ in
				self.passwordField.becomeFirstResponder()
			})
		let passwordDone = passwordField.rx.controlEvent([.editingDidEndOnExit])
			.subscribe(onNext: { _ in
				self.signInAction()
			})
	}

	private func setupTapGesture() {
		let taper = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
		addGestureRecognizer(taper)
	}

	private func setupScrollView() {
		addSubview(scrollView)
		scrollView.easy.layout(Edges())
		scrollView.addSubview(contentView)
		contentView.easy.layout(Edges(), Width().like(self), Height().like(self).with(.low))
	}

	private func setupSignInButton() {
		contentView.addSubview(signInButton)
		signInButton.easy.layout(
			Top(20).to(passwordField, .bottom),
			Height(47),
			Left(40).to(self, .left),
			Right(40).to(self, .right)
		)
		signInButton.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
	}
	
	private func setupSignUpButton() {
		contentView.addSubview(signUpButton)
		signUpButton.easy.layout(
			Top().to(orLabel, .bottom),
			Height(47),
			Left(40).to(self, .left),
			Right(40).to(self, .right)
		)
		signUpButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
	}
	
	private func setupOrLabel() {
		contentView.addSubview(orLabel)
		orLabel.easy.layout(
			Top(20).to(signInButton, .bottom),
			Height(40),
			Left(40).to(self, .left),
			Right(40).to(self, .right)
		)
	}
	
	private func setupEmailField() {
		contentView.addSubview(emailField)
		emailField.easy.layout(Left(40),
													 Right(40),
													 Top(50).to(self.safeAreaLayoutGuide, .top),
													 Height(50))
	}
	
	private func setupPasswordField() {
		contentView.addSubview(passwordField)
		passwordField.easy.layout(Left(40),
															Right(40),
															Top(16).to(emailField, .bottom),
															Height(50))
	}
	
	private func setupSignInForm() {
		setupEmailField()
		setupPasswordField()
	}
	
	// MARK: - actions
	
	@objc private func hideKeyboardAction() {
		endEditing(true)
	}
	
	@objc private func signUpAction() {
		guard let email = emailField.text,
			let password = passwordField.text else { return }
		delegate?.signUpEvent(email: email, password: password)
	}
	
	@objc private func signInAction() {
		guard let email = emailField.text,
			let password = passwordField.text else { return }
		delegate?.signInEvent(email: email, password: password)
	}
}
