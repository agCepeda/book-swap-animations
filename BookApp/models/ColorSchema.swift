//
//  ColorSchema.swift
//  BookApp
//
//  Created by Agustin Cepeda on 14/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import UIKit

struct ColorSchema {
    var background: UIColor = UIColor.white
    var text: UIColor = UIColor.black
    var second: UIColor = UIColor.white
    var third: UIColor = UIColor.white
    var card: UIColor = UIColor.white
}

let colorSchemas: [ColorSchema] = [
    ColorSchema(
        background: UIColor(red: 0.439, green: 0.941, blue: 0.776, alpha: 1.0),
        text: UIColor(red: 0.044, green: 0.144, blue: 0.192, alpha: 1.0),
        second: UIColor(red: 0.393, green: 0.849, blue: 0.655, alpha: 1.0),
        third: UIColor(red: 0.338, green: 0.739, blue: 0.580, alpha: 1.0)
    ),
    ColorSchema(
        background: UIColor(red: 0.683, green: 0.440, blue: 0.969, alpha: 1.0),
        text: UIColor(red: 0.992, green: 0.952, blue: 0.612, alpha: 1.0),
        second: UIColor(red: 0.624, green: 0.372, blue: 0.910, alpha: 1.0),
        third: UIColor(red: 0.585, green: 0.310, blue: 0.902, alpha: 1.0)
    ),
    ColorSchema(
        background: UIColor(red: 0.933, green: 0.541, blue: 0.553, alpha: 1.0),
        text: UIColor(red: 0.996, green: 0.972, blue: 0.988, alpha: 1.0),
        second: UIColor(red: 0.913, green: 0.522, blue: 0.463, alpha: 1.0),
        third: UIColor(red: 0.854, green: 0.401, blue: 0.384, alpha: 1.0)
    ),
    ColorSchema(
        background: UIColor(red: 0.776, green: 0.928, blue: 0.576, alpha: 1.0),
        text: UIColor(red: 0.149, green: 0.272, blue: 0.063, alpha: 1.0),
        second: UIColor(red: 0.678, green: 0.846, blue: 0.443, alpha: 1.0),
        third: UIColor(red: 0.596, green: 0.795, blue: 0.353, alpha: 1.0)
    ),
    ColorSchema(
        background: UIColor(red: 0.350, green: 0.405, blue: 0.761, alpha: 1.0),
        text: UIColor(red: 0.914, green: 0.952, blue: 0.992, alpha: 1.0),
        second: UIColor(red: 0.303, green: 0.397, blue: 0.761, alpha: 1.0),
        third: UIColor(red: 0.256, green: 0.334, blue: 0.698, alpha: 1.0)
    ),
    ColorSchema(
        background: UIColor(red: 0.933, green: 0.506, blue: 0.788, alpha: 1.0),
        text: UIColor(red: 0.992, green: 0.960, blue: 0.996, alpha: 1.0),
        second: UIColor(red: 0.921, green: 0.434, blue: 0.776, alpha: 1.0),
        third: UIColor(red: 0.902, green: 0.387, blue: 0.698, alpha: 1.0)
    )
]
