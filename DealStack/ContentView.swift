//
//  ContentView.swift
//  DealStack
//
//  Created by Guilherme Rambo on 03/07/19.
//  Copyright © 2019 Guilherme Rambo. All rights reserved.
//

import SwiftUI

struct Deal: Identifiable {
    var order: Int
    let id: UUID
    let title: String
    let imageName: String
    let formattedPrice: String
}

struct ContentView : View {
    @State var deals: [Deal] = []
    @State var dragOffset: CGSize = .zero

    var body: some View {
        ZStack {
            ForEach(deals) { deal in
                return DealView(deal: deal)
                    .frame(width: 338, height: 220, alignment: .center)
                    .cornerRadius(8)
                    .scaleEffect(0.8 + CGFloat(self.order(for: deal)) * 0.12)
                    .offset(x: 0, y: CGFloat(self.order(for: deal)) * 24.0)
                    .offset(x: self.dragOffset.width * CGFloat(self.order(for: deal)) * 0.2, y: self.dragOffset.height * CGFloat(self.order(for: deal)) * 0.2)
                    .shadow(radius: 20)
                    .animation(.fluidSpring(stiffness: 90, dampingFraction: 0.5)) // This curve will be applied to the offset and scale modifiers
                    .brightness(-0.3 + Double(self.order(for: deal)) * 0.1)
                    .animation(.basic(duration: 0.4, curve: .easeInOut)) // This curve will be applied to the brightness modifier
                    .tapAction {
                        self.bringToFront(deal)
                }.gesture(DragGesture().onChanged({ value in
                    self.dragOffset = value.translation
                }).onEnded({ _ in
                    self.dragOffset = .zero
                }))
            }
        }
    }

    private func order(for deal: Deal) -> Int {
        return deals.firstIndex(where: { $0.id == deal.id })!
    }

    private func bringToFront(_ deal: Deal) {
        guard let idx = deals.firstIndex(where: { $0.id == deal.id }) else { return }

        var mutableDeals = deals
        var mutableDeal = deal

        mutableDeal.order = deals.count + 1

        mutableDeals.remove(at: idx)
        mutableDeals.append(mutableDeal)

        deals = mutableDeals.sorted(by: { $0.order < $1.order })

        print(deals)
    }
}

#if DEBUG
extension Deal {
    static let previewContent: [Deal] = [
        Deal(
            order: 0,
            id: UUID(),
            title: "Buffet Livre de Sushi com Pratos Quentes e 1 Temaki",
            imageName: "deal1",
            formattedPrice: "R$ 69,90"
        ),
        Deal(
            order: 1,
            id: UUID(),
            title: "Festival de Pizza e Massas para até 2 Pessoas",
            imageName: "deal2",
            formattedPrice: "R$ 44,90"
        ),
        Deal(
            order: 2,
            id: UUID(),
            title: "Fondue de Queijo e Chocolate para 2 pessoas",
            imageName: "deal3",
            formattedPrice: "R$ 69,90"
        ),
        Deal(
            order: 3,
            id: UUID(),
            title: "Rodízio de Carnes Completo com Buffet pra até 2 pessoas",
            imageName: "deal4",
            formattedPrice: "R$ 47,90"
        )
    ]
}

struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(deals: Deal.previewContent.sorted(by: { $0.order < $1.order }))
    }
}
#endif
