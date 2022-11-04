//
//  ColorPaletteView.swift
//  mvgarbuzovPW2
//
//  Created by Matvey Garbuzov on 24.09.2022.
//

import Foundation
import UIKit

protocol ChangeColorDelegate {
  func changeColor(_ slider: ColorPaletteView)
}

final class ColorPaletteView: UIControl {
  var delegate: ChangeColorDelegate?
  private var stackView = UIStackView()
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
    let redControl = ColorSliderView(
      colorName: "R", value: Float(chosenColor.redComponent))
    let greenControl = ColorSliderView(
      colorName: "G", value: Float(chosenColor.greenComponent))
    let blueControl = ColorSliderView(
      colorName: "B", value: Float(chosenColor.blueComponent))
    redControl.tag = 0
    greenControl.tag = 1
    blueControl.tag = 2
    
    stackView.axis = .vertical
    stackView.distribution = .equalSpacing
    stackView.addArrangedSubview(redControl)
    stackView.addArrangedSubview(greenControl)
    stackView.addArrangedSubview(blueControl)
    stackView.backgroundColor = .white
    stackView.layer.cornerRadius = 12
    [redControl, greenControl, blueControl].forEach {
      $0.addTarget(self, action: #selector(sliderMoved(slider:)),
                   for: .touchDragInside)
    }
    addSubview(stackView)
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  @objc
  private func sliderMoved(slider: ColorSliderView) {
    switch slider.tag {
    case 0:
      self.chosenColor = UIColor(
        red: CGFloat(slider.value),
        green: chosenColor.greenComponent,
        blue: chosenColor.blueComponent,
        alpha: chosenColor.alphaComponent
      )
    case 1:
      self.chosenColor = UIColor(
        red: chosenColor.redComponent,
        green: CGFloat(slider.value),
        blue: chosenColor.blueComponent,
        alpha: chosenColor.alphaComponent
      )
    default:
      self.chosenColor = UIColor(
        red: chosenColor.redComponent,
        green: chosenColor.greenComponent,
        blue: CGFloat(slider.value),
        alpha: chosenColor.alphaComponent
      )
    }
    sendActions(for: .touchDragInside)
    delegate?.changeColor(self)
    print("!")
  }
}

extension ColorPaletteView {
  private final class ColorSliderView: UIControl {
    private let slider = UISlider()
    private let colorLabel = UILabel()
    
    private(set) var value: Float = 0.0
    
    init(colorName: String, value: Float) {
      self.value = value
      super.init(frame: .zero)
      
      slider.value = value
      colorLabel.text = colorName
      setupView()
      slider.addTarget(
        self,
        action: #selector(sliderMoved),
        for: .touchDragInside
      )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
      let stackView = UIStackView(arrangedSubviews: [colorLabel, slider])
      stackView.axis = .horizontal
      stackView.spacing = 8
      
      addSubview(stackView)
      stackView.snp.makeConstraints { make in
        make.leading.top.equalToSuperview().offset(12)
        make.trailing.bottom.equalToSuperview().offset(-12)
      }
    }
    
    @objc private func sliderMoved(_ slider: UISlider) {
      self.value = slider.value
      sendActions(for: .touchDragInside)
    }
  }
}

extension UIColor {
  var redComponent: CGFloat{ return CIColor(color: self).red }
  var greenComponent: CGFloat{ return CIColor(color: self).green }
  var blueComponent: CGFloat{ return CIColor(color: self).blue }
  var alphaComponent: CGFloat{ return CIColor(color: self).alpha }
}
