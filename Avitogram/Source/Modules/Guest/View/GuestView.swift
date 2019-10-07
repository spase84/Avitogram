//
//  GuestView.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 31.07.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import UIKit
import EasyPeasy

protocol GuestViewDelegate: class {}

class GuestView: UIView {
	private weak var delegate: GuestViewDelegate?

	// subviews
	private let scrollView = UIScrollView()
	private let contentView = UIView()
	private let signInButton: UIButton = {
		let btn = MPRoundedButton(radius: 5, backgroundColor: .SLDullYellow, textColor: .black)
		btn.setTitle("sign in".localized.firstUppercased, for: .normal)
		return btn
	}()
	private let signUpButton: UIButton = {
		let btn = UIButton()
		btn.setTitle("sign up".localized.firstUppercased, for: .normal)
		btn.setTitleColor(.SLDullYellow, for: .normal)
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
		field.backgroundColor = .SLWhite
		field.layer.cornerRadius = 6
		field.clipsToBounds = true
		field.keyboardAppearance = .dark
		return field
	}()
	private let passwordField: UITextField = {
		let field = UITextField(padding: 10)
		field.isSecureTextEntry = true
		field.backgroundColor = .SLWhite
		field.attributedPlaceholder = "password".localized.firstUppercased.attributed(attributes: Settings.shared.placeholderAttrs)
		field.layer.cornerRadius = 6
		field.clipsToBounds = true
		field.keyboardAppearance = .dark
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
	}
	
	private func setupSignUpButton() {
		contentView.addSubview(signUpButton)
		signUpButton.easy.layout(
			Top().to(orLabel, .bottom),
			Height(47),
			Left(40).to(self, .left),
			Right(40).to(self, .right)
		)
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
		emailField.easy.layout(Left(40), Right(40), Top(50).to(self.safeAreaLayoutGuide, .top), Height(50))
	}
	
	private func setupPasswordField() {
		contentView.addSubview(passwordField)
		passwordField.easy.layout(Left(40), Right(40), Top(16).to(emailField, .bottom), Height(50))
	}
	
	private func setupSignInForm() {
		setupEmailField()
		setupPasswordField()
	}
	
	// MARK: - actions
	
	@objc private func hideKeyboardAction() {
		endEditing(true)
	}
}
