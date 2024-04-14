//
//  CoinDataService.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-03-31.
//

import Foundation
import Combine

class CoinDataService{
    let baseURl = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=250&page=1&sparkline=true&price_change_percentage=24h?x_cg_pro_api_key=CG-Kn77CExSCifZkz7Y5hBAiqKj"
    @Published var allCoins: [CoinModel] = []
    var coinSubscripition: AnyCancellable?
    
    init(){
        getCoins()
    }
    
     func getCoins(){
        coinSubscripition = NetworkingManager.download(urlString: baseURl)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] returnedCoins in
                    self?.allCoins = returnedCoins
                    self?.coinSubscripition?.cancel()
                })
    }
}
