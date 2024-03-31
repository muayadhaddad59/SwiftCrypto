//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-03-30.
//

import Foundation


class HomeViewModel: ObservableObject{
    @Published var allCoins: [CoinModel] = []
    @Published var porfolioCoins: [CoinModel] = []
    
    
    init(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.porfolioCoins.append(DeveloperPreview.instance.coin)
        }
    }
}
