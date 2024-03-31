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
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                ContentView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm  )
        }
    }
}
