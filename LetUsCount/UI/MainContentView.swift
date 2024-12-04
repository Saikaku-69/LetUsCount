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
            TaskListView()
                .tabItem {
                    Image(systemName: "tray.full.fill")
                }
            GraphView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                }
//            GraphSampleView()
//                .tabItem {
//                    Image(systemName: "tray.and.arrow.up")
//                }
        }
    }
}

#Preview {
    MainContentView()
        .environmentObject(TaskDataManager())
}
