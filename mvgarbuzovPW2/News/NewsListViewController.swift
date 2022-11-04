//
//  NewsListViewController.swift
//  mvgarbuzovPW2
//
//  Created by Matvey Garbuzov on 04.11.2022.
//

import Foundation
import UIKit

final class NewsListViewController: UIViewController {
  
  private let tableView = UITableView(frame: .zero, style: .plain)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  private func setupUI() {
    view.backgroundColor = .systemGray6
  }
}
