//
//  PhoneListView.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/13.
//

import SwiftUI

struct PhoneListView: View {
    @EnvironmentObject var phoneDataManager: PhoneDataManager
    
    var body: some View {
        HStack {
            List {
                ForEach (phoneDataManager.phoneModel) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        
                        Button(action: {
                            phoneDataManager.phoneIncrement(for: item)
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(PlainButtonStyle()) //禁止选择整行
                        
                        Text("\(item.count)")
                            .frame(width: 50)
                        
                        Button(action: {
                            phoneDataManager.phoneDecrement(for: item)
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}

#Preview {
    PhoneListView()
        .environmentObject(PhoneDataManager())
}
