//
//  NoteCell.swift
//  mvgarbuzovPW2
//
//  Created by Matvey Garbuzov on 01.11.2022.
//

import Foundation
import UIKit

final class NoteCell: UITableViewCell {
  
  private var textView = UITextView()
  
  static let reuseIdentifier = "NoteCell"
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupView()
    backgroundColor = .systemGray6
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    addSubview(textView)
    
    textView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
      make.top.equalToSuperview().offset(5)
      make.height.equalToSuperview()
    }
  }
  
  func configure(note: ShortNote) {
    textView.text = note.text
    textView.font = .systemFont(ofSize: 16, weight: .regular)
    textView.textContainer.maximumNumberOfLines = 1
    textView.textColor = .black
    textView.backgroundColor = .clear
  }
}
