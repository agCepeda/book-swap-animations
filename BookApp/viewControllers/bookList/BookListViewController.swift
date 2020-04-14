//
//  BookListViewController.swift
//  BookApp
//
//  Created by Agustin Cepeda on 01/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

let bookCollection: [Book] = [
    Book(
        name: "Thinner",
        image: "book1",
        author: "Stephen King",
        color: UIColor(red:0.27, green:0.96, blue:0.80, alpha:1.00)
    ),
    Book(
        name: "The Outside Boy",
        image: "book2",
        author: "Jeanine Cummins",
        color: UIColor(red:0.75, green:0.49, blue:1.00, alpha:1.00)
    ),
    Book(
        name: "Orange Clockwork",
        image: "book4",
        author: "Anthony Burgess",
        color: UIColor(red:0.78, green:0.93, blue:0.58, alpha:1.00)
    ),
    Book(
        name: "The Last Wild",
        image: "book5",
        author: "Piers Torday",
        color: UIColor(red:0.39, green:0.47, blue:0.83, alpha:1.00)
    ),
    Book(
        name: "Harry Potter and the Chamber Of Secrets",
        image: "book6",
        author: "J.K. Rowling",
        color: UIColor(red:0.98, green:0.54, blue:0.83, alpha:1.00)
    )
]

class BookListViewController: UIViewController {
    
    struct Constants {
        static let swapControllerSegue = "showSwapController"
    }

    @IBOutlet var selectionView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var book1ImageView: UIImageView!
    weak var bookImageView: UIImageView!
    weak var selectedCell: BookItemTableViewCell!
    
    @IBOutlet weak var myBookContainerView: UIView!
    @IBOutlet weak var myBookNameLabel: UILabel!
    @IBOutlet weak var myBookAuthorLabel: UILabel!
    
    var bookContainerView: UIView {
        return self.selectedCell.contentView
    }
    
    var bookNameLabel: UILabel {
        return self.selectedCell.nameLabel
    }
    
    var bookAuthorLabel: UILabel {
        return self.selectedCell.authorLabel
    }
    
    @IBOutlet weak var myBookImageView: UIImageView!
    
    var myBook: Book? {
        didSet {
            guard let book = self.myBook else { return }
            myBookNameLabel.text = book.name
            myBookAuthorLabel.text = book.author
            myBookImageView.image = UIImage(named: book.image)
           
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView!.register(UINib(nibName: "BookItemTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        myBook = Book(
            name: "1Q84",
            image: "book3",
            author: "Murakami",
            color: UIColor(red:0.98, green:0.60, blue:0.60, alpha:1.00)
        )
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.swapControllerSegue,
            let book1 = self.myBook,
            let book2 = sender as? Book,
            let controller = segue.destination as? BookSwapViewController {
            controller.setBooks(book1: book1, book2: book2)
        }
    }

}

extension BookListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BookItemTableViewCell
        cell.book = bookCollection[indexPath.row]
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
    
        self.performSegue(withIdentifier: Constants.swapControllerSegue, sender: cell.book)
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
