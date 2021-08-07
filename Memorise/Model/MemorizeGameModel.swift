//
//  MemorizeGameModel.swift
//  Memorise
//
//  Created by NoobMaster69 on 30/07/2021.
//

import Foundation
import SwiftUI

struct MemorizeGameModel<T:Equatable> {
    var score: Int = 0
    var theme: Theme
    private(set) var cards: [Card]
    private var lastIndexSelected: Int?
    {
        get {
            let indices = cards.indices.filter { cards[$0].isFacedUp }
            return indices.count == 1 ? indices.first : nil
        }
        set { cards.indices.forEach { cards[$0].isFacedUp = $0 == newValue } }
    }


    init(theme: Theme, numberOfCardPairs: Int, initCardContent: (Int) -> T) {
        self.theme = theme
        cards = []
        for i in 0..<numberOfCardPairs {

            let cardContent = initCardContent(i)
            cards.append(Card(id: i * 2, content: cardContent))
            cards.append(Card(id: i * 2 + 1, content: cardContent))
        }
        cards.shuffle()
    }


    mutating func choose(_ card: Card) {
        if let idx = cards.firstIndex(where: { $0.id == card.id }), !cards[idx].isMatched {
            
            if cards[idx].cardScore > 0 {
                cards[idx].cardScore -= 1
            }
            if let lastIdx = lastIndexSelected {

                if cards[lastIdx].content == cards[idx].content && idx != lastIdx {
                    cards[lastIdx].isMatched = true
                    cards[idx].isMatched = true
                    score += cards[idx].cardScore + cards[lastIdx].cardScore
                }
                cards[idx].isFacedUp = true

            }
            else {
                lastIndexSelected = idx
            }
        }
    }

    struct Card: Identifiable {
        let id: Int
        var cardScore: Int = 11
        var isMatched: Bool = false
        var isFacedUp: Bool = false
        var content: T

    }

    struct Theme {
        let name: ThemesRepository.Theme
        let cardSet: [T]
        var backgroundColor: Color
    }

}
