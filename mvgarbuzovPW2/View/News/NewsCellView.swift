//
//  NewsCellView.swift
//  mvgarbuzovPW2
//
//  Created by Matvey Garbuzov on 04.11.2022.
//

import Foundation
import UIKit

final class NewsCellView: UITableViewCell {
  
  static let reuseIdentifier = "NewsCell"
  private let newsImageView = UIImageView()
  private let newsTitleLabel = UILabel()
  private let newsDescriptionLabel = UILabel()
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = .none
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  func setupView() {
    setupImageView()
    setupTitleLabel()
    setupDescriptionLabel()
  }
  
  func setupImageView() {
    newsImageView.layer.cornerRadius = 8
    newsImageView.layer.cornerCurve = .continuous
    newsImageView.clipsToBounds = true
    newsImageView.contentMode = .scaleToFill
    newsImageView.backgroundColor = .secondarySystemBackground
    
    contentView.addSubview(newsImageView)
    newsImageView.snp.makeConstraints { make in
      make.top.bottom.leading.equalToSuperview().inset(12)
      make.width.equalTo(newsImageView.snp.height)
    }
  }
  
  func setupTitleLabel() {
    newsTitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
    newsTitleLabel.textColor = .label
    newsTitleLabel.numberOfLines = 1
    
    contentView.addSubview(newsTitleLabel)
    newsTitleLabel.snp.makeConstraints { make in
      make.leading.equalTo(newsImageView.snp.trailing).offset(12)
      make.top.trailing.equalToSuperview().inset(12)
    }
  }
  
  func setupDescriptionLabel() {
    newsDescriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
    newsDescriptionLabel.textColor = .secondaryLabel
    newsDescriptionLabel.numberOfLines = 0
    
    contentView.addSubview(newsDescriptionLabel)
    newsDescriptionLabel.snp.makeConstraints { make in
      make.leading.equalTo(newsImageView.snp.trailing).offset(12)
      make.top.equalTo(newsTitleLabel.snp.bottom).offset(12)
      make.trailing.bottom.equalToSuperview().inset(12)
    }
  }
  
  public func configure(_ viewModel: NewsViewModel ) {
    newsTitleLabel.text = viewModel.title
    newsDescriptionLabel.text = viewModel.description
    if let data = viewModel.imageData {
      newsImageView.image = UIImage(data: data)
    } else if let url = viewModel.imageURL {
      URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data else {
          return
        }
        viewModel.imageData = data
        DispatchQueue.main.async {
          self.newsImageView.image = UIImage(data: data)
        }
      }.resume()
    }
  }
  
  func onLoadConfigure(){
    newsImageView.image = UIImage(systemName: "arrow.2.circlepath")
    newsTitleLabel.text = "Loading in progress..."
    newsDescriptionLabel.text = "Please stand by..."
  }
}

