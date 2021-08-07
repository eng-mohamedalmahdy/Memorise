//
//  CardImageView.swift
//  Memorise
//
//  Created by NoobMaster69 on 27/07/2021.
//

import SwiftUI

struct CardImageView: View {

    var card: MemorizeGameModel<String>.Card
    private typealias Constants = CardDrawingConstants

    var body: some View {
        GeometryReader { geo in
            ZStack {

                Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 110 - 90)).fill().padding(5).opacity(0.5)

                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 0 : 360))
                    .animation(Animation.easeInOut.repeatForever())
                    .font(Font.system(size: Constants.fontSize))
                    .scaleEffect(Constants.scaleFont(using: geo.size))
            }.cardify(isFacedUp: card.isFacedUp)
                .opacity(card.isMatched && !card.isFacedUp ? 0 : 1)

        }
    }

}

private struct CardDrawingConstants {
    static let fontSize: CGFloat = 25
    static let fontScale: CGFloat = 0.7
    static let cardCornerRadius: CGFloat = 10.0
    static let cardStrokeWidth: CGFloat = 2.0


    static func scaleFont(using size: CGSize) -> CGFloat {
        return min(size.width, size.height) / (fontSize / fontScale)
    }

}

struct CardImageView_Previews: PreviewProvider {
    static var previews: some View {
        let card = MemorizeGameModel<String>.Card(id: 1, content: "")
        CardImageView(card: card)
    }
}
