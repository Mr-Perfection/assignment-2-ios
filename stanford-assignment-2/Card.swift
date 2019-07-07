//
//  Card.swift
//  stanford-assignment-2
//
//  Created by Stephen lee on 6/26/19.
//  Copyright © 2019 Stephen lee. All rights reserved.
//

import Foundation
import UIKit

enum Pattern {
    case filled, striped, outlined
}

struct Properties {
    var color: UIColor
    var pattern: Pattern
    var shape: String
    
    init(color: UIColor, pattern: Pattern, shape: String) {
        self.color = color
        self.pattern = pattern
        self.shape = shape
    }
    
    
}
struct Card {
    var identifier: Int
    var attributedString: NSAttributedString
    var properties: Properties

    var isSelected = false
    
    static let SHAPES = ["▲", "●", "■"]
    static let COLORS = [ UIColor.cyan, UIColor.purple, UIColor.green]
    static let PATTERNS = [Pattern.filled, Pattern.striped, Pattern.outlined]
    
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory;
    }

    private static func getAttributeString(properties props: Properties) -> NSAttributedString {
        var attributes = [ NSAttributedString.Key.foregroundColor: props.color ]
        switch props.pattern {
        case .outlined:
            let updatedAttr = [NSAttributedString.Key.foregroundColor: props.color, NSAttributedString.Key.strokeWidth: 3] as [NSAttributedString.Key : Any]
            
            return NSAttributedString(string: props.shape, attributes: updatedAttr as [NSAttributedString.Key : Any])
            
        case .striped:
            attributes = [ NSAttributedString.Key.foregroundColor: props.color.withAlphaComponent(0.15) ]
        default:
            return NSAttributedString(string: props.shape, attributes: attributes as [NSAttributedString.Key : Any])
        }
        return NSAttributedString(string: props.shape, attributes: attributes as [NSAttributedString.Key : Any])
    }
    private static func getRandomProperties(with shape: String) -> Properties {
        let color = Card.COLORS.randomElement()
        let pattern = Card.PATTERNS.randomElement()
        
        return Properties(color: color!, pattern: pattern!, shape: shape)
    }
    
    init(shape: String) {
        let props = Card.getRandomProperties(with: shape)
        
        self.properties = props
        self.attributedString = Card.getAttributeString(properties: props)
        self.identifier = Card.getUniqueIdentifier()
        
    }
}
