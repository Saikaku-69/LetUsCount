//
//  GrafView.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/13.
//

import SwiftUI

struct GrafView: View {
    @EnvironmentObject var phoneDataManager: PhoneDataManager
    
    var body: some View {
        HStack {
            ForEach(phoneDataManager.phoneModel) { item in
                Rectangle()
                    .fill(.red)
                    .frame(width: 50,height:CGFloat(Int(item.count)) * 10)
            }
        }
    }
}

#Preview {
    GrafView()
        .environmentObject(PhoneDataManager())
}
