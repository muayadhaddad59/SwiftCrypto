//
//  CoinRowView.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-03-30.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing:0){
            leftView
            Spacer()
            
            if showHoldingsColumn{
                centerView
            }
            
            rightView
                .font(.subheadline)
        }}
}

extension CoinRowView{
    private var leftView: some View{
        HStack(spacing: 0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            
            CoinImageview(coin: coin)
                .frame(width: 30,height: 30)
                
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading,6)
                .foregroundStyle(Color.theme.accent)
            
        }
    }
    
    private var centerView: some View{
        VStack(alignment: .trailing){
            Text(coin.currentHoldingsValue.asCurrencyWith6Decimals())
            Text((coin.currentHoldings ?? 0 ).asNumberString())
        }
        .foregroundStyle(Color.theme.accent)
    }
    
    private var rightView: some View{
        VStack(alignment: .trailing){
            Text("\(coin.currentPrice.asCurrencyWith6Decimals())")
                .bold()
                .foregroundStyle(Color.theme.accent)
            
            Text("\(coin.priceChangePercentage24H?.asPercentString() ?? "")")
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0 ) >= 0 ? Color.theme.green : Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
        
    }


#Preview {
    CoinRowView(coin: DeveloperPreview.instance.coin,showHoldingsColumn: true)
        .previewLayout(.sizeThatFits)
}
