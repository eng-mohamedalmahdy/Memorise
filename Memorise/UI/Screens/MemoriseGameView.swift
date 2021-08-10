//
//  ContentView.swift
//  Memorise
//
//  Created by NoobMaster69 on 27/07/2021.
//

import SwiftUI


struct MemoriseGameView: View {

    @State var dealtCards: Set<Int> = []
    @State private var timer: Timer?

    @Namespace var cardNamespace
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
                    .matchedGeometryEffect(id: card.id, in: cardNamespace)
                    .padding(.all, 5)
                    .transition(.asymmetric(insertion: .identity, removal: .scale).animation(.easeInOut(duration: 1)))
                    .onTapGesture { withAnimation(.linear) { gameViewModel.chooseCard(card) } }


            }
        }.padding(.all, 10)

        let emojiesButton = Button(action: { dealtCards = []; gameViewModel.newGame(theme: .Emojies) }, label: {
                VStack {
                    Image(systemName: "face.smiling.fill")
                    Text(ThemesRepository.Theme.Emojies.rawValue)
                }

            }).padding(20)

        let heartsButton = Button(action: { dealtCards = []; gameViewModel.newGame(theme: .Hearts) }, label: {
                VStack {
                    Image(systemName: "heart.fill")
                    Text(ThemesRepository.Theme.Hearts.rawValue)
                }

            }).padding(20)

        let vehiclesButton = Button(action: { dealtCards = []; gameViewModel.newGame(theme: .Vehicles) }, label: {
                VStack {
                    Image(systemName: "car.fill")
                    Text(ThemesRepository.Theme.Vehicles.rawValue)
                }

            }).padding(20)

        let newGameButton = Text("New Game").onTapGesture {
            dealtCards = []
            gameViewModel.newGame(theme: ThemesRepository.randomTheme())

        }

        VStack {
            scoreBoard

            cards


            HStack { undealtDeckBody.padding(10) ; Spacer() ; matchedDeckBody.padding(10) }
            
            newGameButton

            HStack { emojiesButton ; Spacer() ; heartsButton ; Spacer() ; vehiclesButton }

            Spacer()


        }.foregroundColor(gameViewModel.theme.backgroundColor)




    }

    var matchedDeckBody: some View {
        ZStack {
            ForEach(gameViewModel.cards.filter{$0.isMatched}.reversed()) { card in

                CardImageView(card: card)
                    .matchedGeometryEffect(id: card.id, in: cardNamespace)
                    .transition(.asymmetric(insertion: .opacity, removal: .identity))

            }
        }.frame(width: CardDrawingConstants.deckWidth, height: CardDrawingConstants.deckHeight)
            
    }


    var undealtDeckBody: some View {
        ZStack {
            ForEach(gameViewModel.cards.filter(isUndealt)) { card in

                CardImageView(card: card)
                    .zIndex(zIndex(of: card))
                    .matchedGeometryEffect(id: card.id, in: cardNamespace)
                    .transition(.asymmetric(insertion: .opacity, removal: .identity))


            }
        }.frame(width: CardDrawingConstants.deckWidth, height: CardDrawingConstants.deckHeight)
            .onTapGesture {
            gameViewModel.cards.forEach { card in
                withAnimation(dealAnimation(for: card)) {
                    deal(card: card)
                }
                timer = Timer.scheduledTimer(withTimeInterval: CardDrawingConstants.totalDealingDuration, repeats: false) { _ in
                    withAnimation(.easeInOut(duration: CardDrawingConstants.totalDealingDuration)) {
                        gameViewModel.flipCard(card)
                    }
                    timer?.invalidate()
                }
            }

            timer = Timer.scheduledTimer(withTimeInterval: CardDrawingConstants.totalDealingDuration, repeats: false) { _ in
                withAnimation(.easeInOut(duration: CardDrawingConstants.totalDealingDuration)) {
                    gameViewModel.flipCard(gameViewModel.cards.last!)
                }
                timer?.invalidate()
            }

        }
    }

    private func deal(card: MemoriseGameModel<String>.Card) {
        dealtCards.insert(card.id)
    }

    private func isUndealt(card: MemoriseGameModel<String>.Card) -> Bool {
        return !dealtCards.contains(card.id)
    }

    private func zIndex(of card: MemoriseGameModel<String>.Card) -> Double {
        Double(gameViewModel.cards.firstIndex { card.id == $0.id } ?? 0) * -1
    }


    private func dealAnimation(for card: MemoriseGameModel<String>.Card) -> Animation {

        let index = gameViewModel.cards.firstIndex { $0.id == card.id }

        let delay = Double(index ?? 0) *
            (CardDrawingConstants.totalDealingDuration / Double(gameViewModel.cards.count))
        return Animation.easeInOut(duration: CardDrawingConstants.totalDealingDuration).delay(delay)
    }


    private struct CardDrawingConstants {

        static let deckWidth: CGFloat = 60.0
        static let deckHeight: CGFloat = 90.0
        static let totalDealingDuration = 2.0

    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            let viewModel = MemoriseGameViewModel()
            MemoriseGameView(gameViewModel: viewModel).preferredColorScheme(.light)
            MemoriseGameView(gameViewModel: viewModel).preferredColorScheme(.dark)
        }
    }


}
