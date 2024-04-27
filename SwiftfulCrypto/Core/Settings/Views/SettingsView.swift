//
//  SettingsView.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-04-23.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://youtube.com/c/swiftfulthinking")!
    let coffeeURL =  URL(string:"https://www.buymeacoffee.com")!
    let coinGeckoURL = URL(string: "https://www.coingeco.com")!
    let personalURL = URL(string: "https://www.nicksarno.com")!
    
    var body: some View {
        NavigationStack{
            List{
                swiftfulThinkingSection
                
                coinGeckoSection
                
                develoeprSection
                
                applicationSection
            }
            .font(.headline)
            .tint(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        XMarkButton()
                    }
            })
        }
    }
}

#Preview {
    SettingsView()
}


extension SettingsView{
    private var swiftfulThinkingSection: some View{
        Section(header: Text("Swiftful thinking")) {
            VStack(alignment: .leading){
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was made by following a @swiftfuThinking course on Youtube. It uses MVVM Architechre ")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
                
            }
            .padding(.vertical)
             
            Link("Supscripe on Youtube ",destination: youtubeURL)
            Link("Support his coffee addiction", destination: coffeeURL)
            
        }
    }
    
    private var coinGeckoSection: some View{
        Section(header: Text("CoinGeko")) {
            VStack(alignment: .leading){
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was developer by Muayad Haddad. it uses Swiftfu; and is wriiten 100% in Swift. THe project benefits form multi-thiriding, publishers/subscripiers, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
                
            }
            .padding(.vertical)
             
            Link("visit CoinGeco ",destination: youtubeURL)
            Link("Support his coffee addiction", destination: coffeeURL)
            
        }
    }
    
    private var develoeprSection: some View{
        Section(header: Text("Devloper")) {
            VStack(alignment: .leading){
                Image("logo")
                    .resizable()
                    
                    .frame(width: 100,height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! price may be slightly delayed. ")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
                
            }
            .padding(.vertical)
             
            Link("Visit Websit ",destination: youtubeURL)
            Link("Support his coffee addiction", destination: coffeeURL)
        }
    }
    
    
    private var applicationSection: some View{
        Section(header: Text("Application")) {
            Link("Terms of service",destination: youtubeURL)
            Link("Privacy Policy",destination: youtubeURL)
            Link("Company Website",destination: youtubeURL)
            Link("Learn More",destination: youtubeURL)
        }
    }
}
