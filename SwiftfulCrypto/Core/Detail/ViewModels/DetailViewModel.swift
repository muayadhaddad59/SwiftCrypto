//
//  DetailViewModel.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-04-15.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject{
    
    @Published var overviewStatistics: [StatisticModel] = []
    @Published var addationalStatistics: [StatisticModel] = []
    @Published var coin: CoinModel
    @Published var coinDescription: String? = nil
    @Published var webSiteURL: String? = nil
    @Published var redditURL: String? = nil
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    
    private func addSubscribers(){
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink {[weak self] returnedArrays in
                self?.overviewStatistics = returnedArrays.overview
                self?.addationalStatistics = returnedArrays.addational
            }
            .store(in: &cancellables)
        
        coinDetailService.$coinDetails
            .sink { [weak self] returnedCoinDetails in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.webSiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistics(coinDetailsModel: CoinDetailModel?, coinModel: CoinModel)-> (overview: [StatisticModel], addational: [StatisticModel] ) {
        // Overview
      let overview = createOverViewArray(coinDetailModel: coinDetailsModel, coinModel: coinModel)
        // Adational
      let addationalArray = createAddationalArray(coinDetailModel: coinDetailsModel, coinModel: coinModel)
        return (overview, addationalArray)
    }
    
    func createOverViewArray(coinDetailModel: CoinDetailModel? ,coinModel: CoinModel) -> [StatisticModel] {
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePersentageCahnged = coinModel.priceChange24H
        let priceStat = StatisticModel(title: "Current price", value: price, percentageChange: pricePersentageCahnged)
        
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapStat =  StatisticModel(title: "Market Captilization", value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        
        let volumn = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumnStat = StatisticModel(title: "Valume", value: volumn)
        
        let overview: [StatisticModel] = [
            priceStat, marketCapStat, rankStat, volumnStat
        ]
        return overview
    }
    
    func createAddationalArray(coinDetailModel: CoinDetailModel?,coinModel: CoinModel) -> [StatisticModel] {
        // Adational
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "24h High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat  = StatisticModel(title: "24h Low", value: low)
        
        let priceChang = coinModel.priceChange24H?.asCurrencyWith2Decimals() ?? "n/a"
        
        let pricePerscentChange2 = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChang, percentageChange: pricePerscentChange2)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange2 = coinModel.marketCapChangePercentage24H
        let marketCapChnageStat = StatisticModel(title: "24h MArket Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange2)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blocTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blocStat = StatisticModel(title: "Block time ", value: blocTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "HAshing Algorithm", value: hashing)
        
        let addationalArray: [StatisticModel] = [
            highStat, lowStat, priceChangeStat, marketCapChnageStat, blocStat, hashingStat
        ]
        return addationalArray
    }
}
