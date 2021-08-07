//
//  ContentView.swift
//  Memorise
//
//  Created by NoobMaster69 on 27/07/2021.
//

import SwiftUI


struct MemoriseGameView: View {

    @State var dealtCards: Set<Int> = []

    @ObservedObject var gameViewModel: MemoriseGameViewModel
    private let colCount = 5
    private let rowCount = 5


    var body: some View {

        let scoreBoard = Text("Score \(gameViewModel.score)")

        let cards = AspectVGrid(items: gameViewModel.cards, aspectRatio: 3 / 4) { card in

            if isUndealt(card: card) {
                Color.clear
            }
            else {
                CardImageView(card: card)
                    .aspectRatio(3 / 5, contentMode: .fill)
                    .padding(.all, 5)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity).animation(.easeInOut.delay(3)))
                    .onTapGesture { withAnimation(.easeInOut) { gameViewModel.chooseCard(card) } }

            }
        }.padding(.all, 10)
            .onAppear {
            withAnimation {
                gameViewModel.cards.forEach(deal)
            }
        }


        let emojiesButton = Button(action: { withAnimation { gameViewModel.newGame(theme: .Emojies) } }, label: {
                VStack {
                    Image(systemName: "face.smiling.fill")
                    Text(ThemesRepository.Theme.Emojies.rawValue)
                }

            }).padding(20)

        let heartsButton = Button(action: { withAnimation { gameViewModel.newGame(theme: .Hearts) } }, label: {
                VStack {
                    Image(systemName: "heart.fill")
                    Text(ThemesRepository.Theme.Hearts.rawValue)
                }

            }).padding(20)

        let vehiclesButton = Button(action: { withAnimation { gameViewModel.newGame(theme: .Vehicles) } }, label: {
                VStack {
                    Image(systemName: "car.fill")
                    Text(ThemesRepository.Theme.Vehicles.rawValue)
                }

            }).padding(20)

        let newGameButton = Text("New Game").onTapGesture {
            withAnimation {
                gameViewModel.newGame(theme: ThemesRepository.randomTheme())
            }
        }


        VStack {
            scoreBoard

            cards

            HStack { emojiesButton ; Spacer() ; heartsButton ; Spacer() ; vehiclesButton }

            newGameButton

            Spacer()

        }.foregroundColor(gameViewModel.theme.backgroundColor)



    }

    var deckBody: some View {
        ZStack {
            ForEach(gameViewModel.cards.filter(isUndealt)) { card in
                CardImageView(card: card)
            }
        }.frame(width: CardDrawingConstants.deckWidth, height: CardDrawingConstants.deckHeight)
    }

    private func deal(card: MemorizeGameModel<String>.Card) {
        dealtCards.insert(card.id)
    }

    private func isUndealt(card: MemorizeGameModel<String>.Card) -> Bool {
        return !dealtCards.contains(card.id)
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            let viewModel = MemoriseGameViewModel()
            MemoriseGameView(gameViewModel: viewModel).preferredColorScheme(.light)
            MemoriseGameView(gameViewModel: viewModel).preferredColorScheme(.dark)
        }
    }

    private struct CardDrawingConstants {

        static let deckWidth: CGFloat = 60.0
        static let deckHeight: CGFloat = 90.0
        
    }

}
