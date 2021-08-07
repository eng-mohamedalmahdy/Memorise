//
//  MemoriseGameViewModel.swift
//  Memorise
//
//  Created by NoobMaster69 on 30/07/2021.
//

import Foundation
import SwiftUI

class MemoriseGameViewModel: ObservableObject {




    @Published private var model = initaliseCards(theme: .Emojies)

    private static func initaliseCards(theme: ThemesRepository.Theme) -> MemorizeGameModel<String> {
        
        let gameTheme = ThemesRepository.getTheme(theme)
        return MemorizeGameModel(theme: gameTheme, numberOfCardPairs: Int.random(in: 2..<gameTheme.cardSet.count)) { i in gameTheme.cardSet[i] }
    }



    var cards: [MemorizeGameModel<String>.Card] {
        model.cards
    }

    var theme: MemorizeGameModel<String>.Theme {
        model.theme
    }

    var score: Int { model.score }

    func setTheme(_ theme: ThemesRepository.Theme) {
        model.theme = ThemesRepository.getTheme(theme)
    }

    func chooseCard(_ card: MemorizeGameModel<String>.Card) {
        model.choose(card)
    }

    func newGame(theme: ThemesRepository.Theme) {
        model = MemoriseGameViewModel.initaliseCards(theme: theme)
    }

}
