//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-03-30.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = [] // Corrected 'porfolioCoins' to 'portfolioCoins'
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOption = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>() // Corrected 'cancellabels' to 'cancellables'
    
    
    enum SortOption {
    case rank, rankReversed, holdings, holdingReversed, price, priceReverced
    }
    
    init() {
        addSubscribers() // Corrected 'addSubscripiers' to 'addSubscribers'
    }
    
    private func addSubscribers() {
        // MARK: - Updates All coins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // Update PortfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinstoPortfolioCoins)
            .sink { [weak self] returnedCoins in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        // Update markData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
   
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double){
        portfolioDataService.updatedPortfolio(coin: coin, amount: amount)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else { return coins }
        let lowerCasedText = text.lowercased()
        
        return coins.filter { coin -> Bool in
            return coin.name.lowercased().contains(lowerCasedText) ||
                coin.symbol.lowercased().contains(lowerCasedText) ||
                coin.id.lowercased().contains(lowerCasedText)
        }
    }
    
    
    func reloadData(){
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HApticManager.notification(type: .success)
    }
    
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel]{
        var updatedCoins = filterCoins(text: text, coins: coins)
        // Sort
        sortCoins(sort: sort, coin: &updatedCoins)
        return updatedCoins
    }

    
    private func sortCoins(sort: SortOption, coin: inout [CoinModel]){
        switch sort {
        case .rank, .holdings:
            /// Hard way
//            return coin.sorted(by: {$0.rank < $1.rank})
            /// Easy way
             coin.sort { coin1, coin2 -> Bool in
                 coin1.rank < coin2.rank
            }
        case .rankReversed, .holdingReversed:
             coin.sort(by: {$0.rank > $1.rank})
        case .price:
             coin.sort(by: {$0.currentPrice > $1.currentPrice})
        case . priceReverced:
             coin.sort(by: {$0.currentPrice < $1.currentPrice})
       
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel]{
        // Will only sort by holdings or reversedHoldings if needed
        switch sortOption {
       
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
        case .holdingReversed:
            return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
        default:
            return coins
        
        }
    }
    

    private func mapAllCoinstoPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntirty]) -> [CoinModel]{
        allCoins
            .compactMap { coin -> CoinModel? in
                guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id})
                else{
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    private func mapGlobalMarketData(data: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = data else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        stats.append(marketCap)
        
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        /// Hardest way
        let portfolioValue =
        portfolioCoins
            .map{($0.currentHoldingsValue)}
            .reduce(0, +)
        
        /// Easiest way
//        let portfolioValue = portfolioCoins.map { coin -> Double in
//            return coin.currentHoldingsValue
//        }
        
        let previewValue =
        portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let persentChange = (coin.priceChangePercentage24H ?? 0.0) / 100
                let previousValue = currentValue / (1 + persentChange)
                return previousValue
                // 25% -> 25 -> 0.25
            }
            .reduce(0,+)
        
        let persentageChaneg = ((portfolioValue - previewValue) /  previewValue) * 100
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(),percentageChange: persentageChaneg)
        
        stats.append(contentsOf: [
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
}
