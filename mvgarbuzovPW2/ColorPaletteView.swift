//
//  ColorPaletteView.swift
//  mvgarbuzovPW2
//
//  Created by Matvey Garbuzov on 24.09.2022.
//

import Foundation
import UIKit

final class ColorPaletteView: UIControl {
  private let stackView = UIStackView()
  private(set) var chosenColor: UIColor = UIColor.systemGray6
  
  init() {
    super.init(frame: .zero)
    
    setupView()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    
  }
}
