//
//  NoteCell.swift
//  mvgarbuzovPW2
//
//  Created by Matvey Garbuzov on 01.11.2022.
//

import Foundation
import UIKit

final class NoteCell: UITableViewCell {
  
  private lazy var textView = UILabel() // UITextView()
  
  static let reuseIdentifier = "NoteCell"
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupView()
    backgroundColor = .systemGray6
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    addSubview(textView)
    
    textView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(14)
    }
  }
  
  func configure(note: ShortNote) {
    textView.text = note.text
    textView.font = .systemFont(ofSize: 16, weight: .regular)
    textView.textColor = .black
    textView.backgroundColor = .clear
//    textView.textContainer.maximumNumberOfLines = 0
    textView.numberOfLines = 0
  }
}
