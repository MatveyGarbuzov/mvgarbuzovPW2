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

extension ColorPaletteView {
  private final class colorSliderView: UIControl {
    private let slider = UISlider()
    private let colorLabel = UILabel()
    
    private(set) var value: Float = 0.0
    
    init(colorName: String, value: Float) {
      self.value = value
      super.init(frame: .zero)
      
      slider.value = value
      colorLabel.text = colorName
      setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
      let stackView = UIStackView(arrangedSubviews: [colorLabel, slider])
      stackView.axis = .horizontal
      stackView.spacing = 8
      stackView.backgroundColor = .green
      
      addSubview(stackView)
      stackView.snp.makeConstraints { make in
        make.edges.equalToSuperview().inset(
          UIEdgeInsets(
            top: 16,
            left: 16,
            bottom: 16,
            right: 16
          )
        )
      }
    }
  }
}
