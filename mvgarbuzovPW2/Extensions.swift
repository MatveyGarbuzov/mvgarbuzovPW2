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
