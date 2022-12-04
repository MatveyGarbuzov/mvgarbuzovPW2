//
//  NewsListModel.swift
//  mvgarbuzovPW2
//
//  Created by Matvey Garbuzov on 04.12.2022.
//

import Foundation

final class NewsViewModel {
  let title: String
  let description: String
  let imageURL: URL?
  var imageData: Data? = nil
  init(title: String, description: String, imageURL: URL?) {
    self.title = title
    self.description = description
    self.imageURL = imageURL
  }
}

enum Model {
  struct News: Decodable{
    let status: String
    let totalResults: Int
    let articles: [Article]
  }
  
  struct Article: Decodable{
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
  }
  
  struct Source: Decodable {
    let id: String?
    let name: String
  }
}
