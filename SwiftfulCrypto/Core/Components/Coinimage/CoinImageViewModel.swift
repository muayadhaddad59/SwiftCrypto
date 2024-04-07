//
//  CoinImageViewModel.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-03-31.
//

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject{
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
   private var cancellabels = Set<AnyCancellable>()
    private let dataService: CoinImageService
    private let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscripers()
        self.isLoading = true
    }
    
    private func addSubscripers(){
        dataService.$image
            .sink {[weak self] _ in
                self?.isLoading = false
            } receiveValue: {[weak self] returnImage in
                self?.image = returnImage
            }
            .store(in: &cancellabels)
    }
}
