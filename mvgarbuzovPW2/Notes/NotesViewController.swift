//
//  NotesViewController.swift
//  mvgarbuzovPW2
//
//  Created by Matvey Garbuzov on 31.10.2022.
//

import Foundation
import UIKit

final class NotesViewController: UIViewController {
  
  private let tableView = UITableView(frame: .zero, style: .insetGrouped)
  private var dataSource = [
    ShortNote(text: "a"),
    ShortNote(text: "b"),
    ShortNote(text: "c")
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupView()
  }
  
  private func setupView() {
    setupTableView()
    setupNavBar()
  }
  
  private func setupTableView() {
    tableView.register(NoteCell.self, forCellReuseIdentifier:
                        NoteCell.reuseIdentifier)
    view.addSubview(tableView)
    tableView.backgroundColor = .clear
    tableView.keyboardDismissMode = .onDrag
    tableView.dataSource = self
    tableView.delegate = self
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setupNavBar() {
    self.title = "Notes"
  }
  
  private func handleDelete(indexPath: IndexPath) {
    dataSource.remove(at: indexPath.row)
    tableView.reloadData()
  }
  
  @objc
  func dismissViewController(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
}

extension NotesViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
  UITableViewCell {
    let note = dataSource[indexPath.row]
    if let noteCell = tableView.dequeueReusableCell(
      withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as? NoteCell {
      noteCell.configure(note: note)
      return noteCell
    }
    return UITableViewCell()
  }
}



extension NotesViewController: UITableViewDelegate {
  
}
