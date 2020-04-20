//
//  Book.swift
//  BookApp
//
//  Created by Agustin Cepeda on 05/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

struct Book {
    var name: String = ""
    var image: String = ""
    var author: String = ""
    var authorImage: String = ""
    var abstract: String = ""
    var color: UIColor = UIColor.init(red: 0.9, green: 0.5, blue: 0.7, alpha: 1.0)
}

let bookCollection: [Book] = [
    Book(
        name: "Thinner",
        image: "book1",
        author: "Stephen King",
        abstract: "Halleck, an arrogant and morbidly obese lawyer in Connecticut, has recently fought an agonizing court case in which he was charged with vehicular manslaughter.",
        color: UIColor(red:0.27, green:0.96, blue:0.80, alpha:1.00)
    ),
    Book(
        name: "The Outside Boy",
        image: "book2",
        author: "Jeanine Cummins",
        abstract: "Young Christy Hurley is a Pavee gypsy, traveling with his father and extended family from town to town, carrying all their worldly possessions in their wagons.",
        color: UIColor(red:0.75, green:0.49, blue:1.00, alpha:1.00)
    ),
    Book(
        name: "Orange Clockwork",
        image: "book4",
        author: "Anthony Burgess",
        abstract: "In a futuristic Britain, Alex DeLarge is the leader of a gang of \"droogs\": Georgie, Dim and Pete. One night, after getting intoxicated on drug-laden \"milk-plus\", ",
        color: UIColor(red:0.78, green:0.93, blue:0.58, alpha:1.00)
    ),
    Book(
        name: "The Last Wild",
        image: "book5",
        author: "Piers Torday",
        abstract: "In a world where animals no longer exist, twelve-year-old Kester Jaynes sometimes feels like he hardly exists either. Locked away in a home for troubled children, he's told there's something wrong with him.",
        color: UIColor(red:0.39, green:0.47, blue:0.83, alpha:1.00)
    ),
    Book(
        name: "Harry Potter and the Chamber Of Secrets",
        image: "book6",
        author: "J.K. Rowling",
        abstract: "Harry Potter spends the summer with The Dursleys without receiving letters from his Hogwarts friends. In his room, Harry meets Dobby, a house-elf who warns him of a peril that will take shape if he returns to Hogwarts.",
        color: UIColor(red:0.98, green:0.54, blue:0.83, alpha:1.00)
    ),
    Book(
        name: "The Last Wild",
        image: "book5",
        author: "Piers Torday",
        abstract: "In a world where animals no longer exist, twelve-year-old Kester Jaynes sometimes feels like he hardly exists either. Locked away in a home for troubled children, he's told there's something wrong with him.",
        color: UIColor(red:0.39, green:0.47, blue:0.83, alpha:1.00)
    )
]
