//
//  WelcomeViewController.swift
//  mvgarbuzovPW2
//
//  Created by Matvey Garbuzov on 20.09.2022.
//

import UIKit
import SnapKit

final class WelcomeViewController: UIViewController, ConstraintRelatableTarget {
  
  // MARK: - Fields
  private let commentView = UIView()
  
  private let commentLabel = UILabel()
  private let valueLabel = UILabel()
  
  private var horizontalStack = UIStackView()
  private var buttonsStackView = UIStackView()
  
  private let incrementButton = UIButton()
  private var localizationButton = UIButton()
  
  private let colorPaletteView = ColorPaletteView()
  private let notesViewController = NotesViewController()
  
  private var value: Int = 0
  private var language = Language.Russian
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  private func setupView() {
    view.backgroundColor = .systemGray6
    
    setupIncrementButton()
    setupLocalizationButton()
    setupCenterButtons()
    setupValueLabel()
    setupCommentView()
    setupMenuButtons()
    setupColorControlSV()
    
    updateUI()
  }
  
  // MARK: - Private func
  
  private func setupColorControlSV() {
    view.addSubview(colorPaletteView)
    colorPaletteView.alpha = 0
    colorPaletteView.isEnabled = false
    
    colorPaletteView.snp.makeConstraints { make in
      make.top.equalTo(incrementButton.snp.bottom).offset(8)
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().offset(-24)
      make.bottom.equalTo(buttonsStackView.snp.top).offset(-8)
    }
  }
  
  private func setupNotesView() {
    
  }
  
  // Setup default language in app
  private func setupLanguage() {
    String().saveLanguage("eu")
  }
  
  private func setupIncrementButton() {
    incrementButton.configure(title: String(localized: "buttonTitle"))
    
    incrementButton.addTarget(
      self,
      action: #selector(incrementButtonPressed),
      for: .touchUpInside
    )
  }
  
  private func setupLocalizationButton() {
    localizationButton = makeMenuButton(title: "language".localized)
    
    localizationButton.addTarget(
      self,
      action: #selector(localizationButtonPressed),
      for: .touchUpInside
    )
  }
  
  private func setupCenterButtons() {
    horizontalStack = makeHorizontalStack(views: [incrementButton, localizationButton])
    horizontalStack.distribution = .fillProportionally
    
    view.addSubview(horizontalStack)
    horizontalStack.snp.makeConstraints { make in
      make.height.equalTo(48)
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
      make.center.equalTo(view.center)
    }
  }
  
  private func setupValueLabel() {
    view.addSubview(valueLabel)
    
    valueLabel.font = UIFont.systemFont(ofSize: 40.0, weight: .bold)
    valueLabel.textColor = UIColor.black
    valueLabel.text = String(value)
    
    valueLabel.snp.makeConstraints { make in
      make.bottom.equalTo(incrementButton.snp.top)
      make.centerX.equalToSuperview()
    }
  }
  
  private func setupCommentView() {
    commentView.backgroundColor = UIColor.white
    commentView.layer.cornerRadius = 12
    
    view.addSubview(commentView)
    commentView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.leading.trailing.equalToSuperview().inset(24)
    }
    
    commentLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
    commentLabel.textColor = UIColor.systemGray
    commentLabel.numberOfLines = 0
    commentLabel.textAlignment = .center
    
    commentView.addSubview(commentLabel)
    commentLabel.snp.makeConstraints { make in
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
  
  private func updateCommentLabel(value: Int) {
    switch value {
    case 0...10:
      commentLabel.text = "1"
    case 10...20:
      commentLabel.text = "2"
    case 20...30:
      commentLabel.text = "3"
    case 30...40:
      commentLabel.text = "4"
    case 40...50:
      commentLabel.text = "🎉🎉🎉🎉🎉🎉🎉🎉"
    case 50...60:
      commentLabel.text = "50-60".localized
    case 60...70:
      commentLabel.text = "60-70".localized
    case 70...80:
      commentLabel.text = "⭐️⭐️⭐️⭐️⭐️⭐️⭐️"
    case 80...90:
      commentLabel.text = "80-90".localized
    case 90...100:
      commentLabel.text = "90-100".localized
    default:
      commentLabel.text = "100+".localized
    }
  }
  
  private func animateButton(sender: UIView?) {
    guard let button = sender as? UIButton else { return }
    button.isEnabled = false
    
    button.layer.cornerRadius = Const.Sizes.buttonCornerRadiusPressed
    
    button.backgroundColor = UIColor(
      red: 0.85,
      green: 0.85,
      blue: 0.85,
      alpha: 0.8
    )
    
    UIView.animate(withDuration: Const.animationDuration, animations: {
      button.alpha = 1
      button.layer.cornerRadius = Const.Sizes.buttonCornerRadius
      button.backgroundColor = .white
    }) { completion in
      button.isEnabled = true
    }
  }
  
  private func makeMenuButton(title: String) -> UIButton {
    let button = UIButton()
    button.configure(title: title)
    
    button.snp.makeConstraints { make in
      make.height.equalTo(button.snp.width)
    }
    
    return button
  }
  
  private func makeHorizontalStack(views: [UIView]) -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: views)
    stackView.spacing = 12
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    
    return stackView
  }
  
  private func setupMenuButtons() {
    let colorButton = makeMenuButton(title: "🎨")
    colorButton.addTarget(self, action: #selector(paletteButtonPressed), for: .touchUpInside)
    let noteButton = makeMenuButton(title: "📝")
    noteButton.addTarget(self, action:
        #selector(notesButtonPressed), for: .touchUpInside)
    let newsButton = makeMenuButton(title: "📰")
    
    buttonsStackView = makeHorizontalStack(
      views: [colorButton, noteButton, newsButton]
    )
    
    view.addSubview(buttonsStackView)
    buttonsStackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(24)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-24)
    }
  }
  
  // update text for value/comment labels and increment/lang buttons
  private func updateUI() {
    let animation = {
      self.valueLabel.text = String(self.value)
      self.updateCommentLabel(value: self.value)
      self.incrementButton.setTitle("buttonTitle".localized, for: .normal)
      self.localizationButton.setTitle("language".localized, for: .normal)
    }
    UIView.transition(with: commentLabel, duration: Const.animationDuration, options: .transitionFlipFromTop, animations: animation, completion: nil)
    UIView.transition(with: valueLabel, duration: Const.animationDuration, options: .transitionFlipFromBottom, animations: animation, completion: nil)
    UIView.transition(with: incrementButton, duration: Const.animationDuration, options: .transitionCrossDissolve, animations: animation, completion: nil)
    UIView.transition(with: localizationButton, duration: Const.animationDuration, options: .transitionCrossDissolve, animations: animation, completion: nil)
  }
  
  // create vibration feedback
  private func impactFeedbackGenerator() {
    let generator = UIImpactFeedbackGenerator(style: .light)
    generator.impactOccurred()
  }
  
  // change language in app
  private func changeLanguage() {
    if language == .English {
      String().saveLanguage("ru")
      language = .Russian
    } else {
      String().saveLanguage("en")
      language = .English
    }
    
    updateUI()
  }
  
  // On button press make animation,
  // create vibration feedback and update UI
  private func buttonPressed(sender: UIView?) {
    animateButton(sender: sender)
    impactFeedbackGenerator()
    
    updateUI()
  }
  
  @objc private func localizationButtonPressed(sender: UIView?) {
    changeLanguage()
    
    buttonPressed(sender: sender)
  }
  
  @objc private func incrementButtonPressed(sender: UIView?) {
    value += 1
    
    buttonPressed(sender: sender)
  }
  
  @objc private func paletteButtonPressed(sender: UIView?) {
    buttonPressed(sender: sender)
    
    UIView.animate(withDuration: Const.animationDuration) {
      self.colorPaletteView.alpha = self.colorPaletteView.isEnabled ? 0 : 1
    }
    self.colorPaletteView.isEnabled.toggle()
    changeColor(colorPaletteView)
  }
  
  @objc func notesButtonPressed() {
    impactFeedbackGenerator()
    
    let notesViewController = UINavigationController(rootViewController: NotesViewController())
    if let sheetController = notesViewController.sheetPresentationController {
//      sheetController.detents = [.medium(), .large()]
      sheetController.detents = [.large()]
      sheetController.preferredCornerRadius = 20
      sheetController.prefersGrabberVisible = true
    }
    present(notesViewController, animated: true, completion: nil)
  }
  
  @objc private func changeColor(_ slider: ColorPaletteView) {
    UIView.animate(withDuration: 0.5) {
      self.view.backgroundColor = slider.chosenColor
    }
  }
}

