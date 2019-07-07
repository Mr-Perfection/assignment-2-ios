//
//  ViewController.swift
//  stanford-assignment-2
//
//  Created by Stephen lee on 6/24/19.
//  Copyright © 2019 Stephen lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let INITIAL_CARDS_COUNT = 12
    private lazy var game = SetGame(numberOfCards: INITIAL_CARDS_COUNT)
    
    @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.selectCard(at: cardNumber)
            if game.selectedCards.count == 3 && isMatched(game.selectedCards) {
                game.setSelectedToMatched()
            }
            updateViewFromModel()
        }
    }
    
    @IBAction func dealThreeCards(_ sender: UIButton) {
        if game.indexOfLastDealtCard <= game.MAX_VISIBLE_CARDS-3 {
            game.indexOfLastDealtCard += 3
            for index in 0..<game.indexOfLastDealtCard {
                cardButtons[index].isHidden = false
            }
        }
        
        updateViewFromModel()
    }
    
    private func resetCards() {
        for index in game.indexOfLastDealtCard..<cardButtons.count {
            cardButtons[index].isHidden = true
        }
    }
    
    private func compareThreeCards(_ first: Card, _ second: Card, _ third: Card) -> Bool {
        let sameColor = (first.properties.color == second.properties.color) && ( first.properties.color == third.properties.color)
        let samePattern = (first.properties.pattern == second.properties.pattern) && (first.properties.pattern == third.properties.pattern)
        let sameShape = (first.properties.shape == second.properties.shape) && (first.properties.shape == third.properties.shape)
        
        // Two attributes are same but the other attribute is different.
        if (!sameColor && samePattern && sameShape) || (sameColor && !samePattern && sameShape) ||
            (sameColor && samePattern && !sameShape) {
            return true
        }
        
        // Two attributes are different but the other attribute is same.
        if (!sameColor && !samePattern && sameShape) || (sameColor && !samePattern && !sameShape) ||
            (!sameColor && samePattern && !sameShape) {
            return true
        }
        
        //Three attributes are different.
        return !sameColor && !samePattern && !sameShape;
    }
    
    private func isMatched(_ selectedCards: [Card]) -> Bool {
        if selectedCards.count == 0 {
            return false
        }
        
       return compareThreeCards(selectedCards[0], selectedCards[1], selectedCards[2]) || compareThreeCards(selectedCards[1], selectedCards[2], selectedCards[0]) || compareThreeCards(selectedCards[2], selectedCards[1], selectedCards[0])
    }
    
    private func updateViewFromModel() {
        let totalVisibleCards = game.indexOfLastDealtCard
        
        for index in 0..<totalVisibleCards {
            let button = cardButtons[index]
            let card = game.deckOfCards.cards[index]
            
            button.setAttributedTitle(card.attributedString, for: UIControl.State.normal)
            if card.isSelected {
                button.layer.borderWidth = 3
                button.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            } else {
                button.layer.borderWidth = 0
            }
        }
        
        resetCards()
    }
}

