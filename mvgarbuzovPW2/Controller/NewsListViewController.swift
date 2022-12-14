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
  private var isLoading = false
  private var newsViewModels = [NewsViewModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    
    if isLoading {
      showSkeleton()
    }
  }
  
  private func setupUI() {
    view.backgroundColor = .systemGray6
    configureTableView()
    configureViewController()
  }
  
  private func configureViewController() {
    self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
  }
  
  private func configureTableView() {
    setupNavBar()
    setTableViewUI()
    setTableViewDelegate()
    setTableViewCell()
    fetchNews()
  }
  
  private func setupNavBar() {
    navigationItem.title = "News"
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "chevron.left"),
      style: .plain,
      target: self,
      action: #selector(goBack)
    )
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "arrow.counterclockwise"),
      style: .plain,
      target: self,
      action: #selector(refresh)
    )
  }
  //
  private func setTableViewUI() {
    view.addSubview(tableView)
    tableView.backgroundColor = .clear
    tableView.separatorStyle = .none
    tableView.rowHeight = 120
    
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setTableViewDelegate() {
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  private func setTableViewCell() {
    tableView.register(NewsCellView.self, forCellReuseIdentifier: NewsCellView.reuseIdentifier)
  }
  
  private func fetchNews() {
    self.isLoading = true
    URLSession.shared.getTopStories { [weak self] result in
      self?.newsViewModels = result.articles.compactMap{
        NewsViewModel(
          title: $0.title,
          description: $0.description ?? "No description",
          imageURL: URL(string: $0.urlToImage ?? "")
        )
        
      }
      DispatchQueue.main.async {
        self?.isLoading = false
        self?.tableView.reloadData()
      }
    }
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
  @objc private func goBack() {
    _ = navigationController?.popViewController(animated: true)
  }
  
  @objc private func refresh() {
    showSkeleton()
    self.fetchNews()
  }
}

extension NewsListViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isLoading {
      return 4
    } else {
      return newsViewModels.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if isLoading {
      if let newsCell = tableView.dequeueReusableCell(withIdentifier: NewsCellView.reuseIdentifier, for: indexPath) as? NewsCellView{
        return newsCell
      }
    } else {
      let viewModel = newsViewModels[indexPath.row]
      if let newsCell = tableView.dequeueReusableCell(
        withIdentifier: NewsCellView.reuseIdentifier, for: indexPath) as? NewsCellView {
        hideSkeleton()
        newsCell.configure(viewModel)
        return newsCell
      }
    }
    return UITableViewCell()
  }
}

extension NewsListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if !isLoading {
      let newsVC = NewsViewController()
      newsVC.configure(with: newsViewModels[indexPath.row])
      navigationController?.pushViewController(newsVC, animated: true)
    }
  }
}

extension NewsListViewController: UIGestureRecognizerDelegate { }
