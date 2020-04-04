//
//  BookItemTableViewCell.swift
//  BookApp
//
//  Created by Agustin Cepeda on 01/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

class BookItemTableViewCell: UITableViewCell {
    @IBOutlet weak var bookImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

class BackgroundView: UIView {
    
    override func draw(_ rect: CGRect) {
        
    }
    
}
