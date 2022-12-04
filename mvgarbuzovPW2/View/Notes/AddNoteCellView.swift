//
//  AddNoteCellView.swift
//  mvgarbuzovPW2
//
//  Created by Matvey Garbuzov on 01.11.2022.
//

import Foundation
import UIKit

protocol AddNoteDelegate: AnyObject {
  func newNoteAdded(note: ShortNote)
}

final class AddNoteCellView: UITableViewCell {
  
  static let reuseIdentifier = "AddNoteCell"
  var delegate: AddNoteDelegate?
  
  private let textView: UITextView = {
    let textView = UITextView()
    textView.font = .systemFont(ofSize: 16, weight: .regular)
    textView.textColor = .black
    textView.backgroundColor = .clear
    textView.isEditable = true
    
    return textView
  }()
  
  var placeholderLabel: UILabel = {
    let label = UILabel()
    label.text = "Enter some text..."
    label.sizeToFit()
    label.textColor = .tertiaryLabel
    
    return label
  }()
  
  private let addButton: UIButton = {
    let button = UIButton()
    button.setTitle("Add new note", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
    button.setTitleColor(.systemBackground, for: .normal)
    button.backgroundColor = .label
    button.layer.cornerRadius = 8
    button.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
    button.isEnabled = true
    button.alpha = 0.8
    
    button.snp.makeConstraints { make in
      make.height.equalTo(45)
    }
    
    return button
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupView()
    backgroundColor = .systemGray6
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    textView.delegate = self
    placeholderLabel.font = .italicSystemFont(ofSize: (textView.font?.pointSize)!)
    textView.addSubview(placeholderLabel)
    placeholderLabel.textColor = .tertiaryLabel
    placeholderLabel.frame.origin = CGPoint(x: 5, y: (textView.font?.pointSize)! / 2)
    placeholderLabel.isHidden = !textView.text.isEmpty
    
    let stackView = UIStackView(arrangedSubviews: [textView, addButton])
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.spacing = 8
    
    contentView.addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.leading.top.equalToSuperview().offset(16)
      make.trailing.bottom.equalToSuperview().offset(-16)
    }
  }
  
  private func clearTextView() {
    textView.text = ""
  }
  
  @objc private func addButtonTapped(_ sender: UIButton) {
    if textView.text != "" {
      delegate?.newNoteAdded(note: ShortNote(text: textView.text))
      clearTextView()
    } else {
      sender.shake()
    }
  }
}


extension AddNoteCellView : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
