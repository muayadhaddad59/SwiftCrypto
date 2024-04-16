//
//  CoinDetailDataService.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-04-15.
//

import Foundation
import Combine

class CoinDetailDataService{
    
    @Published var coinDetails: CoinDetailModel? = nil
    var coinDetailsSubscripition: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel){
        self.coin = coin
        getCoinDetails()
    }
    
     func getCoinDetails(){
         let baseURl = "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
         
         coinDetailsSubscripition = NetworkingManager.download(urlString: baseURl)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] returnedCoinDetails in
                    self?.coinDetails = returnedCoinDetails
                    self?.coinDetailsSubscripition?.cancel()
                })
    }
}
