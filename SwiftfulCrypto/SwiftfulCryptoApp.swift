//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-03-25.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
    
    @State var vm = HomeViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm  )
        }
    }
}
