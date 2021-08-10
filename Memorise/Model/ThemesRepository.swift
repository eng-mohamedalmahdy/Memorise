//
//  ThemesRepository.swift
//  Memorise
//
//  Created by NoobMaster69 on 01/08/2021.
//

import Foundation

struct ThemesRepository {
    enum Theme: String, CaseIterable {
        case Emojies
        case Hearts
        case Vehicles
    }
    private static let emojies =
        ["😀", "🥲", "😍", "😘", "😂",
        "😇", "😉", "😊", "😝", "😔",
        "😕", "🥺", "😡", "😳", "🥵"]

    private static let hearts = ["❤️", "🧡", "💛", "💚", "💙",
                                 "💜", "🖤", "🤍", "🤎", "❤️‍🩹",
                                 "❤️‍🔥", "💔", "❣️", "💕", "💞"]

    private static let vehicles = ["🚗", "🚕", "🚙", "🚌", "🚎",
                                   "🏎", "🚓", "🚑", "🚒", "🚐",
                                   "🛻", "🚚", "🚜", "🚛", "🛺"]

    static func getTheme(_ theme: Theme) -> MemoriseGameModel<String>.Theme {
        switch theme {
        case .Emojies:
            return MemoriseGameModel<String>.Theme(name: .Emojies, cardSet: ThemesRepository.emojies.shuffled(), backgroundColor: .blue)

        case .Hearts:
            return MemoriseGameModel<String>.Theme(name: .Hearts, cardSet: ThemesRepository.hearts.shuffled(), backgroundColor: .red)

        case .Vehicles:
            return MemoriseGameModel<String>.Theme(name: .Vehicles, cardSet: ThemesRepository.vehicles.shuffled(), backgroundColor: .orange)
        }
    }

    static func randomTheme() -> Theme {
        Theme.allCases[Int.random(in: 0..<Theme.allCases.count)]
    }
}
