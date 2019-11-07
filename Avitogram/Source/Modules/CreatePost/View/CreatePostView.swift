//
//  CreatePostView.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 05.11.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import UIKit
import EasyPeasy

protocol CreatePostViewDelegate: class {
	func titleUpdated(text: String)
}

final class CreatePostView: BaseView {
	private weak var delegate: CreatePostViewDelegate?

	// subviews
	private let imageView: UIImageView = {
		let view = UIImageView()
		view.contentMode = .scaleAspectFill
		view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
		view.clipsToBounds = true
		return view
	}()

	private let titleField: UITextField = {
		let field = UITextField()
		field.borderStyle = .none
		field.textColor = .white
		field.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
		field.attributedPlaceholder = "title_placeholder".localized.firstUppercased.attributed(attributes: [.foregroundColor: UIColor.lightGray])
		field.keyboardAppearance = .dark
		return field
	}()

	// MARK: - initializers

	init(delegate: CreatePostViewDelegate) {
		super.init(frame: .zero)
		self.delegate = delegate
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	// MARK: - methods

	func prepareView() {
		addSubview(titleField)
		addSubview(imageView)
		titleField.easy.layout(Top().to(safeAreaLayoutGuide, .top), Left(16), Right(16), Height(50))
		imageView.easy.layout(Top().to(titleField, .bottom), Left(), Right(), Height().like(imageView, .width))

		let taper = UITapGestureRecognizer(target: self, action: #selector(tapAction))
		addGestureRecognizer(taper)

		titleField.delegate = self
		titleField.becomeFirstResponder()
	}

	func set(imageData: Data) {
		imageView.image = UIImage(data: imageData)
	}

	func freeze() {
		titleField.isEnabled = false
		endEditing(true)
	}

	// MARK: - actions

	@objc private func tapAction() {
		endEditing(true)
	}
}

extension CreatePostView: UITextFieldDelegate {
	public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let newText = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
		delegate?.titleUpdated(text: String(newText))
		return true
	}
}
