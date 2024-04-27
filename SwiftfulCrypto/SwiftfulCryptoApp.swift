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
    @State private var showLaunchView: Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            
            ZStack{
                NavigationStack{
                    HomeView()
                        .navigationBarHidden(true)
                }
                .environmentObject(vm  )
                
                ZStack{
                    if showLaunchView{
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
               
               
            }
           
        }
    }
}
