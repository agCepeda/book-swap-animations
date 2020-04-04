//
//  BookListViewController.swift
//  BookApp
//
//  Created by Agustin Cepeda on 01/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController {

    @IBOutlet var selectionView: UIView!
    @IBOutlet weak var tableView: UITableView!
    weak var bookImageView: UIImageView!
    weak var selectedCell: BookItemTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView!.register(UINib(nibName: "BookItemTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension BookListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BookItemTableViewCell
        return cell
    }
}

extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BookItemTableViewCell
            else { return }
        self.bookImageView = cell.bookImageView
        self.selectedCell = cell
        if let navController = self.navigationController {
            navController.delegate = self
        }
    
        self.performSegue(withIdentifier: "showSwapController", sender: nil)
    }
}

extension BookListViewController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .pop:
            return PopAnimator()
        case .push:
            return PushAnimator()
        default:
            return nil
        }
    }
}
