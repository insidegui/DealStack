//
//  PriceView.swift
//  DealStack
//
//  Created by Guilherme Rambo on 04/07/19.
//  Copyright © 2019 Guilherme Rambo. All rights reserved.
//

import SwiftUI

struct PriceView : View {
    @State var formattedPrice: String

    var body: some View {
        ZStack {
            Text(self.formattedPrice)
                .font(.headline)
                .fontWeight(.black)
                .color(.white)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
        }.background(RoundedRectangle(cornerRadius: 8)
            .foregroundColor(.red))
    }
}

#if DEBUG
struct PriceView_Previews : PreviewProvider {
    static var previews: some View {
        PriceView(formattedPrice: "R$ 29,90")
    }
}
#endif
