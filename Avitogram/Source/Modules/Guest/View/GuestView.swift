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
		setupSignUpButton()
		setupOrLabel()
		setupSignInForm()
	}
	
	private func setupSignInButton() {
		addSubview(signInButton)
		signInButton.easy.layout(
			Height(47),
			Left(40).to(self, .left),
			Right(40).to(self, .right),
			Bottom(20).to(orLabel, .top)
		)
	}
	
	private func setupSignUpButton() {
		addSubview(signUpButton)
		signUpButton.easy.layout(
			Height(47),
			Left(40).to(self, .left),
			Right(40).to(self, .right),
			Bottom(40).to(self, .bottom)
		)
	}
	
	private func setupOrLabel() {
		addSubview(orLabel)
		orLabel.easy.layout(
			Height(40),
			Left(40).to(self, .left),
			Right(40).to(self, .right),
			Bottom().to(signUpButton, .top)
		)
	}
	
	private func setupSignInForm() {
		
		setupSignInButton()
	}
}
