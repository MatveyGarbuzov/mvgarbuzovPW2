//
//  Extensions.swift
//  mvgarbuzovPW2
//
//  Created by Matvey Garbuzov on 24.09.2022.
//

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
    layer.cornerRadius = Const.cornerRadiusOfButton
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

extension URLSession{
  func getTopStories(completion: @escaping (Model.News) -> ()) {
    guard let url = URL(
      string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=bf6753dc8bfb47bf964993027ed431d4"
    ) else{ return }
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let data = data,
         let news = try? JSONDecoder().decode(Model.News.self, from: data)
      {
        completion(news)
      }
      else{
        print("Error with get top stories.")
      }
    }
    task.resume()
  }
}

// MARK: CONSTANTS
enum Const {
  // Main Screen
  static let sizeOfCenterButtonsOnMainScreen: CGFloat = 48.0
  static let insetOfCenterButtonsOnMainScreen: CGFloat = 24.0
  static let cornerRadiusOfButton: CGFloat = 12.0
  static let cornerRadiusOfButtonPressed: CGFloat = 18.0
  
  static let cornerRadiusOfCommentView: CGFloat = 12.0
  static let insetOfCommentView: CGFloat = 24.0
  
  static let animationDuration: Double = 0.5
  
  static let sizeOfFontValueLabel: CGFloat = 40.0
  static let sizeOfFontCommentLabel: CGFloat = 14.0
  
  static let spacingOfHorizontalStack: CGFloat = 12.0
  static let bottomOffsetOfHorizontalStack: CGFloat = -24.0
  static let insetOfHorizontalStack: CGFloat = 24.0
  
  static let hidden: CGFloat = 0.0
  static let visible: CGFloat = 1.0
  
  // Other screen
}

// Enum for app localization
enum Language: String {
  case English = "English"
  case Russian = "Russian"
}

extension UIColor {
  var redComponent: CGFloat{ return CIColor(color: self).red }
  var greenComponent: CGFloat{ return CIColor(color: self).green }
  var blueComponent: CGFloat{ return CIColor(color: self).blue }
  var alphaComponent: CGFloat{ return CIColor(color: self).alpha }
}
