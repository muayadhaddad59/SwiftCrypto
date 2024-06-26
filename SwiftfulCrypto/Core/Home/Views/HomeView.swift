//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-03-26.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false // Animate right
    @State private var showPorfoliView: Bool = false // new sheet
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailViwe: Bool = false
    @State private var showSettingsView: Bool = false // new Sheet
    var body: some View {
        ZStack{
            // Background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPorfoliView, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })
            // Content layer
            VStack{
                // Home Header View which containes two ICONS BUTTON
                homeHeader
                
                HomeStatsView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                
                // HEADER Row that displays the header o data
                headerView
                // List: Of Coins and portfolio
                if !showPortfolio{
                    allCoinsList
                        .transition(.move(edge: .leading))
                }else{
                    porfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showSettingsView, content: {
                SettingsView()
            })
        }
        .background(
            NavigationLink(isActive: $showDetailViwe, destination: {DetailLoadinView(coin: $selectedCoin)},
                           label: {EmptyView()})
            
        )
    }
}

#Preview {
    NavigationStack{
        HomeView()
            .navigationBarHidden(true)
    }
    .environmentObject(DeveloperPreview.instance.homeVM)
    
}


// Header
extension HomeView{
    private var homeHeader: some View{
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    showPortfolio ? showPorfoliView.toggle() : showSettingsView.toggle()
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 :  0))
                .onTapGesture {
                    withAnimation {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    
}

// MARK:  All Coins List
extension HomeView{
    private var allCoinsList: some View{
        List{
            ForEach(vm.allCoins){coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    private func segue(coin: CoinModel){
        selectedCoin = coin
        showDetailViwe.toggle()
    }
}




// MARK:  All coin Portolo
extension HomeView{
    private var porfolioCoinsList: some View{
        List{
            ForEach(vm.portfolioCoins){coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
}

// MARK:  -Header View
extension HomeView{
    private var headerView: some View{
        HStack{
            HStack(spacing: 4){
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0: 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            
            showPortfolio ?
            HStack(spacing: 4){
                Text("Holdings")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingReversed) ? 1.0: 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
            }
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .holdings ? .holdingReversed : .holdings
                }
            }
            : nil
            
            HStack(spacing: 4){
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReverced) ? 1.0: 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation {
                    vm.sortOption = vm.sortOption == .price ? .priceReverced : .price
                }
            }
            Button(action: {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            }, label: {
                Image(systemName: "goforward")
            })
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0),anchor: .center)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
