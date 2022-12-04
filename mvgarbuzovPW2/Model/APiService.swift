//
//  APiService.swift
//  mvgarbuzovPW2
//
//  Created by Matvey Garbuzov on 10.11.2022.
//

import Foundation

final class APIService {
  static let shared = APIService()
  
  func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void ) {
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=bf6753dc8bfb47bf964993027ed431d4")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "Get"
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }
      do {
        let obj = try JSONDecoder().decode(News.self, from: data!)
        completion(.success(obj.articles))
      } catch {
        completion(.failure(error))
      }
    }.resume()
  }
}

