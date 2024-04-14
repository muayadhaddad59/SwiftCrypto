//
//  CoinLogoview.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-04-07.
//

import SwiftUI

struct CoinLogoview: View {
    
    let coin : CoinModel
    
    var body: some View {
        VStack{
            CoinImageview(coin: coin)
                .frame(width: 50, height: 50)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
            
        }
    }
}

#Preview {
    CoinLogoview(coin: DeveloperPreview.instance.coin)
}
