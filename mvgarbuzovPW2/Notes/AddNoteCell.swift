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
    textView.font = .systemFont(ofSize: 14, weight: .regular)
    textView.textColor = .tertiaryLabel
    textView.backgroundColor = .red
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
    addButton.isEnabled = false
    addButton.alpha = 0.5
    
    let stackView = UIStackView(arrangedSubviews: [textView, addButton])
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.spacing = 8
    
    addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.leading.top.equalToSuperview().offset(16)
      make.trailing.bottom.equalToSuperview().offset(-16)
    }
  }
  
  @objc private func addButtonTapped(_ sender: UIButton) {
    //    updateUI()
    delegate?.newNoteAdded(note: ShortNote(text: textView.text))
    //    clearTextView()
  }
}
