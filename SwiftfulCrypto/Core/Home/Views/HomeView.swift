//
//  HomeView.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-03-26.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack{
            // Background layer
            Color.theme.background
                .ignoresSafeArea()
            // Content layer
            VStack{
                // Home Header View which containes two ICONS BUTTON
                    homeHeader
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
        }
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
            }
        }
        .listStyle(PlainListStyle())
    }
}
// MARK:  All coin Portolo
extension HomeView{
    private var porfolioCoinsList: some View{
            List{
                ForEach(vm.allCoins){coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                }
            }
            .listStyle(PlainListStyle())
    }
}

// MARK:  -Header View
extension HomeView{
    private var headerView: some View{
        HStack{
            Text("Coin")
            Spacer()
            showPortfolio ? Text("Holdings") : nil
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
