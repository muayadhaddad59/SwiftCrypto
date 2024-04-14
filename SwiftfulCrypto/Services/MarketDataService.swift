//
//  MarketDataService.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-04-03.
//

import Foundation
import Combine

class MarketDataService{
    
    let baseURl = "https://api.coingecko.com/api/v3/global"

    
    @Published var marketData: MarketDataModel? = nil
    
    var marketDataSubscripition: AnyCancellable?
    
    init(){
        getData()
    }
    
    private func getData(){
        marketDataSubscripition = NetworkingManager.download(urlString: baseURl)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] returnedGlobalData in
                    self?.marketData = returnedGlobalData.data
                    self?.marketDataSubscripition?.cancel()
                })
    }
}
