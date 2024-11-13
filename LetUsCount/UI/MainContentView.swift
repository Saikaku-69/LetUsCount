//
//  MainContentView.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/13.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        TabView {
            PhoneListView()
                .tabItem {
                    Image(systemName: "tray.full.fill")
                }
            GrafView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                }
            DataTestView()
                .tabItem {
                    Image(systemName: "tray.and.arrow.up")
                }
        }
    }
}

#Preview {
    MainContentView()
        .environmentObject(PhoneDataManager())
}
