//
//  StatisticsView.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-04-07.
//

import SwiftUI

struct StatisticsView: View {
    
    let stat: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading){
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            
            HStack(spacing:4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees:(stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle((stat.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentageChange == nil ?  0.0 : 1.0)
        }
    }
}

#Preview {
    Group{
        StatisticsView(stat: DeveloperPreview.instance.stat3)
        StatisticsView(stat: DeveloperPreview.instance.stat3)
        StatisticsView(stat: DeveloperPreview.instance.stat3)
    }
    
}
