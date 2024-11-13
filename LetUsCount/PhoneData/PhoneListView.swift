//
//  PhoneListView.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/13.
//

import SwiftUI

struct PhoneListView: View {
    @StateObject var phoneDataManager = PhoneDataManager()
    
    let phoneList = ["iPhoneX",
                     "iPhone11",
                     "iPhone12",
                     "iPhone13"]
    
    var body: some View {
        HStack {
            List {
                ForEach (phoneList,id: \.self) { item in
                    
                    HStack {
                        Text(item)
                        Spacer()
                        
                        Button(action: {
                            phoneDataManager.phoneIncrement()
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(PlainButtonStyle()) //禁止选择整行
                        
                        Text("\(phoneDataManager.phoneCount)")
                            .frame(width: 50)
                        Button(action: {
                            phoneDataManager.phoneDecrement()
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
}
