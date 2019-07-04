//
//  DealView.swift
//  DealStack
//
//  Created by Guilherme Rambo on 04/07/19.
//  Copyright © 2019 Guilherme Rambo. All rights reserved.
//

import SwiftUI

struct DealView: View {
    @State var deal: Deal

    var body: some View {
        ZStack {
            Image(self.deal.imageName)
                .cornerRadius(8)

            VStack {
                HStack {
                    Spacer()
                    PriceView(formattedPrice: self.deal.formattedPrice).shadow(radius: 10)
                }
                .padding()

                Spacer()

                ZStack {
                    Text(deal.title)
                        .font(.headline)
                        .color(.white)
                        .lineLimit(nil)
                        .padding()
                        .shadow(color: .init(.displayP3, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 2, x: 0, y: 1)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .top, endPoint: .bottom))
                        .blendMode(.overlay)
                )
            }
        }
    }
}

#if DEBUG
struct DealView_Previews : PreviewProvider {
    static var previews: some View {
        DealView(deal: Deal.previewContent[0])
            .previewLayout(.fixed(width: 338, height: 220))
    }
}
#endif
