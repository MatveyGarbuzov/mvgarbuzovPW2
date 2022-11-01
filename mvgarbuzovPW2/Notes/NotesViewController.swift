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
    tableView.register(AddNoteCell.self, forCellReuseIdentifier: AddNoteCell.reuseIdentifier)
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
  
  @objc func dismissViewController(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
}

extension NotesViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    default:
      return dataSource.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
  UITableViewCell {
    switch indexPath.section {
    case 0:
      if let addNewCell = tableView.dequeueReusableCell(
        withIdentifier: AddNoteCell.reuseIdentifier, for: indexPath) as? AddNoteCell {
        addNewCell.delegate = self

        return addNewCell
      }
      
    default:
      let note = dataSource[indexPath.row]
      if let noteCell = tableView.dequeueReusableCell(
        withIdentifier: NoteCell.reuseIdentifier, for: indexPath) as? NoteCell {
        noteCell.configure(note: note)
        return noteCell
      }
    }
    return UITableViewCell()
  }
}

extension NotesViewController: AddNoteDelegate {
  func newNoteAdded(note: ShortNote) {
    dataSource.insert(note, at: 0)
    tableView.reloadData()
  }
}

extension NotesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt
                 indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    if indexPath.row != 0 {  // Disable AddNewCell deleteAction
      let deleteAction = UIContextualAction(
        style: .destructive,
        title: .none
      ) { [weak self] (action, view, completion) in
        self?.handleDelete(indexPath: indexPath)
        completion(true)
      }
      deleteAction.image = UIImage(
        systemName: "trash.fill",
        withConfiguration: UIImage.SymbolConfiguration(weight: .bold)
      )?.withTintColor(.white)
      deleteAction.backgroundColor = .red
      return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    return UISwipeActionsConfiguration()
  }
}
