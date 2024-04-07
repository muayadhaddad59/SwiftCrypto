//
//  CoinImageview.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-03-31.
//

import SwiftUI

struct CoinImageview: View {
    @StateObject var vm: CoinImageViewModel
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    var body: some View {
        ZStack{
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }else if vm.isLoading{
                ProgressView()
            }else{
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
}

#Preview {
    CoinImageview(coin: DeveloperPreview.instance.coin)
}
