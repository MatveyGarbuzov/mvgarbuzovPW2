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
  private let userDefaults = UserDefaults.standard
  
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
    tableView.register(NoteCellView.self, forCellReuseIdentifier:
                        NoteCellView.reuseIdentifier)
    tableView.register(AddNoteCellView.self, forCellReuseIdentifier: AddNoteCellView.reuseIdentifier)
    
    tableView.backgroundColor = .clear
    tableView.keyboardDismissMode = .onDrag
    tableView.dataSource = self
    tableView.delegate = self
    
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setupNavBar() {
    self.title = "Notes"
    
    let closeButton = UIButton(type: .close)
    closeButton.addTarget(self, action: #selector(dismissViewController(_:)),
                          for: .touchUpInside)
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      customView: closeButton)
  }
  
  private func handleDelete(indexPath: IndexPath) {
    userDefaults.dataSource.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
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
      return userDefaults.dataSource.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
  UITableViewCell {
    switch indexPath.section {
    case 0:
      if let addNewCell = tableView.dequeueReusableCell(
        withIdentifier: AddNoteCellView.reuseIdentifier, for: indexPath) as? AddNoteCellView {
        addNewCell.delegate = self
        addNewCell.selectionStyle = .none
        return addNewCell
      }
      
    default:
      let note = userDefaults.dataSource[indexPath.row]
      if let noteCell = tableView.dequeueReusableCell(
        withIdentifier: NoteCellView.reuseIdentifier, for: indexPath) as? NoteCellView {
        noteCell.configure(note: note)
        return noteCell
      }
    }
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.beginUpdates()
    tableView.endUpdates()
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    tableView.beginUpdates()
    tableView.endUpdates()
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 1 {
      if self.tableView.indexPathForSelectedRow?.row == indexPath.row {
        return UITableView.automaticDimension // Expanded size of cell
      } else {
        return 48 // Collapsed size of cell
      }
    }
    return 250 // AddNewNote height
  }
}

extension NotesViewController: AddNoteDelegate {
  func newNoteAdded(note: ShortNote) {
    userDefaults.dataSource.insert(note, at: 0)
    tableView.reloadData()
  }
}

// Swipe action for cells
extension NotesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt
                 indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    if indexPath.section != 0 {  // Disable AddNewCell deleteAction
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

extension UserDefaults {
  var dataSource: [ShortNote] {
    get {
      guard let data = UserDefaults.standard.data(forKey: "notes") else { return [] }
      return (try? PropertyListDecoder().decode([ShortNote].self, from: data)) ?? []
    }
    set {
      UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "notes")
    }
  }
}
