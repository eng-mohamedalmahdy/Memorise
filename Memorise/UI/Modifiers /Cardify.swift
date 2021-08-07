//
//  Cardify.swift
//  Memorise
//
//  Created by NoobMaster69 on 07/08/2021.
//

import SwiftUI

struct Cardify: ViewModifier, AnimatableModifier {

    private typealias Constants = CardDrawingConstants


    var isFacedUp: Bool
    var rotationAngle: Double
    {
        get { isFacedUp ? 0 : 180 }
        set { }
    }
    var animatableData: Double {
        get { rotationAngle }
        set { rotationAngle = newValue }
    }

    func body(content: Content) -> some View {
        ZStack {
            let square = RoundedRectangle(cornerRadius: Constants.cardCornerRadius)

            if rotationAngle < 90 {
                square.fill().foregroundColor(.white)
                square.strokeBorder(lineWidth: Constants.cardStrokeWidth)
            }
            else {
                square.fill()
            }
            content.opacity(rotationAngle < 90 ? 1 : 0)

        }.rotation3DEffect(
            Angle.degrees(rotationAngle),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }

}

private struct CardDrawingConstants {
    static let cardCornerRadius: CGFloat = 10.0
    static let cardStrokeWidth: CGFloat = 2.0
    static let fontScale: CGFloat = 0.7

    static func calculateFont(geometryProxy geo: GeometryProxy) -> CGFloat {
        (min(geo.size.width, geo.size.height) * fontScale)
    }

}

extension View {
    func cardify(isFacedUp: Bool) -> some View {
        self.modifier(Cardify(isFacedUp: isFacedUp))
    }
}
