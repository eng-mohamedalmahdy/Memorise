//
//  MemoriseApp.swift
//  Memorise
//
//  Created by NoobMaster69 on 27/07/2021.
//

import SwiftUI

@main
struct MemoriseApp: App {
    private let game = MemoriseGameViewModel()

    var body: some Scene {
        WindowGroup {
            MemoriseGameView(gameViewModel: game)
        }
    }
}
