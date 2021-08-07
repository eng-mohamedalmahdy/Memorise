//
//  AspectVGrid.swift
//  Memorise
//
//  Created by NoobMaster69 on 02/08/2021.
//

import SwiftUI

struct AspectVGrid<T:Identifiable, V:View>: View {
    var items: [T]
    var aspectRatio: CGFloat
    var content: (T) -> V

    init(items: [T], aspectRatio: CGFloat, @ViewBuilder content: @escaping (T) -> V) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }

    var body: some View {
        GeometryReader { proxy in
            let width: CGFloat = calculateWidth(itemCount: items.count, in: proxy.size, itemAspectRatio: aspectRatio)

            LazyVGrid(columns: [adaptiveGridItem(width: width)])
            {
                ForEach(items) { item in
                    content(item).aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }

    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var item = GridItem(.adaptive(minimum: width))
        item.spacing = 0
        return item
    }

    private func calculateWidth(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio

            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }

            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        }
        while columnCount < itemCount

        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(size.width / CGFloat(columnCount))

    }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
