//
//  CoreGraphics+extensions.swift
//  BookApp
//
//  Created by Agustin Cepeda on 16/04/20.
//  Copyright © 2020 Agustin Cepeda. All rights reserved.
//

import CoreGraphics

extension CGPoint {
    func difference(point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x - self.x, y: point.y - self.y)
    }
}

extension CGRect {
    func translate(x: CGFloat, y: CGFloat) -> CGRect {
        return CGRect(
            origin: CGPoint(
                x: self.origin.x + x,
                y: self.origin.y + y
            ),
            size: self.size
        )
    }
}
