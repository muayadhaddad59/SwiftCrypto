//
//  DetailView.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-04-15.
//

import SwiftUI

struct DetailLoadinView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack{
            if let coin = coin {
                DetailView(coin: coin )
            }
        }
    }
}


struct DetailView: View {
    @StateObject var vm: CoinDetailViewModel
    private let columns:  [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    private var spacing: CGFloat = 30
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
        
    }
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                Text("HI")
                    .frame(height: 150)
                
              // MARK: - OverView Body
              overviewTitle
                Divider()
               overviewGrid
                
                // MARK: - Addational Body
                addationalTitle
                Divider()
                addaionalGrid
            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
    }
}

#Preview {
    NavigationStack{
        DetailView(coin: DeveloperPreview.instance.coin)
    }
}


extension DetailView{
    private var overviewTitle: some View{
        Text("OverView")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    
    private var addationalTitle: some View{
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View{
        LazyVGrid(columns: columns,alignment:.leading, spacing: spacing, content: {
            ForEach(vm.overviewStatistics) { stat in
                StatisticsView(stat: stat)
            }
        })
    }
    
    
    private var addaionalGrid: some View{
        LazyVGrid(columns: columns,alignment:.leading, spacing: spacing, content: {
            ForEach(vm.addationalStatistics) { stat in
                StatisticsView(stat: stat)
            }
        })
    }
}
