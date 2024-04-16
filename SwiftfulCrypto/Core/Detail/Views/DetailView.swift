//
//  DetailView.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-04-15.
//

import SwiftUI

struct DetailView: View {
    
    let coin: CoinModel
    
    
    init(coin: CoinModel) {
        self.coin = coin
        print("Initalizing detail view for \(coin.name)")
    }
    var body: some View {
        Text(coin.name)
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
}
