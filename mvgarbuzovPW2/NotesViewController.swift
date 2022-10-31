//
//  NotesViewController.swift
//  mvgarbuzovPW2
//
//  Created by Matvey Garbuzov on 31.10.2022.
//

import Foundation
import UIKit

final class NotesViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .green
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    setupView()
  }
  
  private func setupView() {
    setupNavBar()
  }
  
  private func setupNavBar() {
    self.title = "Notes"
  }
}
