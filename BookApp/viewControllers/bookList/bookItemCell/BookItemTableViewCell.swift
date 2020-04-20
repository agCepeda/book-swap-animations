//
//  BookItemTableViewCell.swift
//  BookApp
//
//  Created by Agustin Cepeda on 01/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

class BookItemTableViewCell: UITableViewCell {
    @IBOutlet weak var animableView: BackgroundView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var ownerLabel: UILabel!
    
    var book: Book? {
        didSet {
            guard let book = self.book else { return }
            animableView.backgroundColor = book.color
            nameLabel.text = book.name
            authorLabel.text = book.author
            coverImageView.image = UIImage(named: book.image)
        }
    }
    var schema: ColorSchema? {
        didSet {
            guard let schema = self.schema else { return }
            animableView.backgroundColor = schema.background
            animableView.secondColor = schema.second
            animableView.thirdColor = schema.third
            nameLabel.textColor = schema.text
            authorLabel.textColor = schema.text
            ownerLabel.textColor = schema.third.darker(by: 15)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        UIImage(systemName: "")?.withRenderingMode(.alwaysTemplate)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
