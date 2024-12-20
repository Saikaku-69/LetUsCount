//
//  LetUsCountApp.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/13.
//

import SwiftUI

@main
struct LetUsCountApp: App {
    @StateObject private var taskDataManager = TaskDataManager()
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environmentObject(taskDataManager)
        }
    }
}
