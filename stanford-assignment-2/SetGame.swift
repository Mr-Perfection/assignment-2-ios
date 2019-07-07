//
//  SetGame.swift
//  stanford-assignment-2
//
//  Created by Stephen lee on 6/30/19.
//  Copyright © 2019 Stephen lee. All rights reserved.
//

import Foundation

class SetGame {
    let MAX_DEAL_COUNT = 3
    let MAX_VISIBLE_CARDS = 20
    
    var indexOfLastDealtCard = 0
    var deckOfCards = DeckOfCards()
    var selectedCards = [Card]()
    
    init(numberOfCards: Int) {
        indexOfLastDealtCard = numberOfCards
        deckOfCards.capacity = numberOfCards
    }

    func selectCard(at index: Int) {
        assert(index < indexOfLastDealtCard, "Cards must have already been dealt. index: \(index) indexOfLastDealtCard: \(indexOfLastDealtCard)")
        if selectedCards.count == 3 {
            deselectAllCards()
        }
        
        let selectedCard = deckOfCards.cards[index]
        if !selectedCard.isSelected {
            selectedCards.append(selectedCard)
            deckOfCards.cards[index].isSelected = true
        } else {
            if let selectedCardIndex = deckOfCards.cards.firstIndex(where: {$0.identifier == selectedCard.identifier}) {
                deckOfCards.cards[selectedCardIndex].isSelected = false
            }
            selectedCards.removeAll(where: { $0.identifier == selectedCard.identifier})
        }
    }
    
    func deselectAllCards() {
        for index in deckOfCards.cards.indices {
            deckOfCards.cards[index].isSelected = false
        }
        selectedCards = []
    }
    
    func dealThreeCards() {
        assert(indexOfLastDealtCard < deckOfCards.LIMIT-3, "Dealt cards must not exceed 81 cards including 3 undealt cards indexOfLastDealtCard: \(indexOfLastDealtCard)")
        indexOfLastDealtCard += 3
    }
    
    func setSelectedToMatched() {
        var set = [Card]()
        for index in selectedCards.indices {
            if let cardIndex = deckOfCards.cards.firstIndex(where: { $0.identifier == selectedCards[index].identifier }) {
                set.append(deckOfCards.cards[cardIndex])
                deckOfCards.cards.remove(at: cardIndex)
            }
        }
        deckOfCards.sets.append(set)
        indexOfLastDealtCard -= 3
    }
}
