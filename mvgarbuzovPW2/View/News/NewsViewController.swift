//
//  NewsViewController.swift
//  mvgarbuzovPW2
//
//  Created by Matvey Garbuzov on 10.11.2022.
//

import Foundation
import UIKit


final class NewsViewController: UIViewController {
  
  private var imageView = UIImageView()
  private var titleLabel = UILabel()
  private var descriptionLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  // MARK: - Private methods
  private func setupUI() {
    view.backgroundColor = .systemBackground
    setupNavbar()
    setImageView()
    setTitleLabel()
    setDescriptionLabel()
  }
  
  private func setupNavbar() {
    navigationItem.title = "News"
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "chevron.left"),
      style: .plain,
      target: self,
      action: #selector(goBack)
    )
    navigationItem.leftBarButtonItem?.tintColor = .label
  }
  
  private func setImageView() {
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    view.addSubview(imageView)
    imageView.snp.makeConstraints { make in
      make.width.equalToSuperview()
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      make.height.equalTo(imageView.snp.width)
    }
  }
  
  private func setTitleLabel() {
    titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
    titleLabel.numberOfLines = 0
    titleLabel.textColor = .label
    view.addSubview(titleLabel)
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(12)
      make.leading.trailing.equalToSuperview().inset(16)
      make.height.greaterThanOrEqualTo(16)
    }
  }
  
  private func setDescriptionLabel() {
    descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
    descriptionLabel.numberOfLines = 0
    descriptionLabel.textColor = .secondaryLabel
    view.addSubview(descriptionLabel)
    descriptionLabel.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(16)
      make.top.equalTo(titleLabel.snp.bottom).offset(8)
    }
  }
  
  // MARK: - Public Methods
  public func configure(with viewModel: NewsViewModel) {
    titleLabel.text = viewModel.title
    descriptionLabel.text = viewModel.description
    if let data = viewModel.imageData {
      imageView.image = UIImage(data: data)
    }
    else if let url = viewModel.imageURL {
      URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
        guard let data = data else {
          return
        }
        viewModel.imageData = data
        DispatchQueue.main.async {
          self?.imageView.image = UIImage(data: data)
        }
      }.resume()
    }
  }
  
  // MARK: - Objc functions
  @objc
  func goBack() {
    self.navigationController?.popViewController(animated: true)
  }
  
}
