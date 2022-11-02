//
//  Extensions.swift
//  mvgarbuzovPW2
//
//  Created by Matvey Garbuzov on 24.09.2022.
//

import Foundation
import UIKit

// Extension makes shadow for Views
extension CALayer {
  func applyShadow() {
    shadowColor = UIColor.darkGray.cgColor
    shadowOpacity = 0.1
    shadowOffset = .zero
    shadowRadius = 10
  }
}

// Extension for custom button cofiguration
extension UIButton {
  func configure(title: String) {
    setTitle(title, for: .normal)
    setTitleColor(UIColor.black, for: .normal)
    layer.cornerRadius = Const.Sizes.buttonCornerRadius
    titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
    backgroundColor = UIColor.white
    layer.applyShadow()
  }
}

// Extension for text localization
extension String {
  var localized: String {
    let lang = currentLanguage()
    let path = Bundle.main.path(forResource: lang, ofType: "lproj")
    let bundle = Bundle(path: path!)
    return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
  }
  
  func saveLanguage(_ lang: String) {
    UserDefaults.standard.set(lang, forKey: "Locale")
    UserDefaults.standard.synchronize()
  }
  
  func currentLanguage() -> String {
    return UserDefaults.standard.string(forKey: "Locale") ?? ""
  }
}

// Shake animation
extension UIView {
  func shake() {
    let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    animation.duration = 0.6
    animation.values = [-6.0, 6.0, -6.0, 6.0, -4.0, 4.0, -2.0, 2.0, 0.0]
    layer.add(animation, forKey: "shake")
  }
}

enum Const {
  static let animationDuration: Double = 0.5
  enum Sizes {
    static let buttonCornerRadius: CGFloat = 12
    static let buttonCornerRadiusPressed: CGFloat = 18
  }
}

// Enum for app localization
enum Language: String {
  case English = "English"
  case Russian = "Russian"
}
//
//enum Keys: String {
//    case dataSource = "dataSource"
//}
