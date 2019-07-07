//
//  Deck.swift
//  stanford-assignment-2
//
//  Created by Stephen lee on 6/26/19.
//  Copyright © 2019 Stephen lee. All rights reserved.
//

import Foundation
import UIKit

class DeckOfCards {
    /**
        81 cards
     **/
    let LIMIT = 81
    
    var capacity = 0
    var cards = [Card]()
    var sets = [[Card]]()

    init() {
        for _ in 0..<LIMIT / Card.SHAPES.count {
            for index in 0..<Card.SHAPES.count {
//                let colorAttr = [ NSAttributedString.Key.foregroundColor: COLORS.randomElement()?.withAlphaComponent(0.15) ]
//                let pattern = NSAttributedString(string: SHAPE_TYPES[shapeIndex], attributes: colorAttr as [NSAttributedString.Key : Any])
                
                cards.append(Card(shape: Card.SHAPES[index]))
            }
        }
    }
}
