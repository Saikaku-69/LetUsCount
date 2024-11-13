//
//  GrafView.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/13.
//

import SwiftUI

struct GraphView: View {
    @EnvironmentObject var phoneDataManager: PhoneDataManager
    
    var body: some View {
        HStack {
            ForEach(phoneDataManager.phoneModels) { item in
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(.green)
                        .frame(width: 25,height:CGFloat(Int(item.count)) * 10)
                }
                .frame(height:500)
            }
        }
    }
}

#Preview {
    GraphView()
        .environmentObject(PhoneDataManager())
}
