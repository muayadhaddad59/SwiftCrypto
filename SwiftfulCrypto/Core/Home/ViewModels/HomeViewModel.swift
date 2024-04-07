//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-03-30.
//

import Foundation
import Combine

struct StatisticModel{
    let title: String
    let value: String
    var percentageChange: Double?
}

class HomeViewModel: ObservableObject{
    
    @Published var statistics: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var porfolioCoins: [CoinModel] = []
    
    @Published  var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellabels = Set<AnyCancellable>()
    
    init(){
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
        //            self.allCoins.append(DeveloperPreview.instance.coin)
        //            self.porfolioCoins.append(DeveloperPreview.instance.coin)
        //        }
        addSubscripiers()
    }
    
    private func addSubscripiers(){
//        dataService.$allCoins
//            .sink { [weak self] returnedCoins in
//                self?.allCoins = returnedCoins
//            }
//            .store(in: &cancellabels)
  
        // MARK: - Updates All coins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink {[weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellabels)
        
        marketDataService.$marketData
            
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
            }
            .store(in: &cancellabels)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else{ return coins}
        let lowerCasedText = text.lowercased()
        
        return coins.filter { coin -> Bool in
            return coin.name.lowercased().contains(lowerCasedText) ||
            coin.symbol.lowercased().contains(lowerCasedText) ||
            coin.id.lowercased().contains(lowerCasedText)
        }
        
    }
    
    
    private func mapGlobalMarketData(data: MarketDataModel?) -> [StatisticModel]{
            var stats: [StatisticModel] = []
            
            guard let data = data else{
                return stats
            }
            
            let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
            stats.append(marketCap)
            
            let volume = StatisticModel(title: "24h Volume", value: data.volume)
            let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
            let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00")
            stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
            ])
            return stats
        
    }
}

