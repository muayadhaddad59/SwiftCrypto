//
//  CircleButtonView.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-03-26.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width: 50,height: 50)
            .background(
                Circle()
                                .foregroundColor(.theme.background)
            )
            .shadow(color: .theme.accent.opacity(0.25), radius: 10,x: 0 ,y:0)
            .padding()
    }
}

#Preview {
    Group{
        CircleButtonView(iconName: "heart.fill")
            .padding()
            .previewLayout(.sizeThatFits)
        
        CircleButtonView(iconName: "heart.fill")
            .padding()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
  
}
