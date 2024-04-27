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
    @StateObject var vm: DetailViewModel
    @State private var showFullDesc: Bool = false
    private let columns:  [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    private var spacing: CGFloat = 30
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        
    }
    var body: some View {
        ScrollView{
            VStack{
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing: 20){
                    overviewTitle
                    Divider()
                    
                    descriptionDesction
                    
                    overviewGrid
                    addationalTitle
                    Divider()
                    addaionalGrid
                    
                    
                    websitSection
                    
                }
                .padding()
            }
            
        }
        .navigationTitle(vm.coin.name)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTralingItems
            }
        }
    }
}

#Preview {
    NavigationStack{
        DetailView(coin: DeveloperPreview.instance.coin)
    }
}


extension DetailView{
    
    
    private var websitSection: some View{
        VStack(alignment: .leading, spacing: 20){
            if let webSiteURL = vm.webSiteURL, let url = URL(string: webSiteURL){
                Link("Website",destination: url)
            }
            if let redditString = vm.redditURL, let url = URL(string:  redditString){
                Link("Reddit", destination:  url)
            }
        }
        .tint(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
        
    }
    
    private var descriptionDesction: some View{
        ZStack(alignment: .leading){
            if let coinDescription = vm.coinDescription,
               !coinDescription.isEmpty{
                VStack{
                    Text(coinDescription)
                        .lineLimit(showFullDesc ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                    
                    Button{
                        withAnimation(.easeInOut) {
                            showFullDesc.toggle()
                        }
                    }label: {
                        Text(showFullDesc ? "Less" : "Read more..")
                            .font(.caption)
                            .bold()
                            .padding(.vertical, 4)
                            .foregroundStyle(.blue)
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
        }
    }
    
    private var navigationBarTralingItems: some View{
        HStack{
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
            
            CoinImageview(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
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
