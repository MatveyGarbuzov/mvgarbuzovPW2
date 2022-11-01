//
//  AddNoteCell.swift
//  mvgarbuzovPW2
//
//  Created by Matvey Garbuzov on 01.11.2022.
//

import Foundation
import UIKit

protocol AddNoteDelegate: AnyObject {
  func newNoteAdded(note: ShortNote)
}

final class AddNoteCell: UITableViewCell {
  
  static let reuseIdentifier = "AddNoteCell"
  
  private var textView = UITextView()
  
  var addButton = UIButton()
  var delegate: AddNoteDelegate?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupView()
    backgroundColor = .systemGray6
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    print("AddNoteCell setupView")
    textView.font = .systemFont(ofSize: 16, weight: .regular)
    textView.textColor = .black
    textView.backgroundColor = .clear
    textView.isEditable = true
    textView.snp.makeConstraints { make in
      make.height.equalTo(150)
    }
    
    addButton.setTitle("Add new note", for: .normal)
    addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
    addButton.setTitleColor(.systemBackground, for: .normal)
    addButton.backgroundColor = .label
    addButton.layer.cornerRadius = 8
    addButton.snp.makeConstraints { make in
      make.height.equalTo(45)
    }
    addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
    addButton.isEnabled = true
    addButton.alpha = 0.8
    
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

extension UIView {
  func shake() {
    let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    animation.duration = 0.6
    animation.values = [-6.0, 6.0, -6.0, 6.0, -4.0, 4.0, -2.0, 2.0, 0.0]
    layer.add(animation, forKey: "shake")
  }
}
