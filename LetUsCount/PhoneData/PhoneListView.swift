//
//  PhoneListView.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/13.
//

import SwiftUI

struct PhoneListView: View {
    @EnvironmentObject var phoneDataManager: PhoneDataManager
    @StateObject var phoneEditManager = PhoneEditManager()
    @State private var itemToDelect: PhoneModel?
    @State private var editText:String = ""
    
    var body: some View {
        
        HStack {
            List {
                ForEach (phoneDataManager.phoneModels) { item in
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
                    .swipeActions {
                        Button(role: .destructive) {
                            
                            itemToDelect = item
                            phoneEditManager.delectMessage = true
                            
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
                
                Button(action: {
                    
                    phoneEditManager.editMessage = true
                    
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green)
                }
                .buttonStyle(PlainButtonStyle())
                
            }
        }
        .alert("入力してください", isPresented: $phoneEditManager.editMessage) {
            TextField("名称",text: $editText)
            Button(action: {
                print(editText)
                
                // 入力したeditTextをphoneModelsのnameに代入する
                
                
                editText = ""
                print(editText)
            }) {
                Text("確定")
            }
            
        }
        .alert(isPresented: $phoneEditManager.delectMessage) {
            Alert(title: Text("警告"), message: Text("削除でよろしいですか？"),
                  primaryButton: .default(Text("Delect"), action: {
                
                delect()
                
            }),
                  secondaryButton: .cancel(Text("Cancel"), action: {}))
        }
    }
    private func delect() {
        if let index = phoneDataManager.phoneModels.firstIndex(where: {$0.id == itemToDelect?.id})  {
            phoneDataManager.phoneModels.remove(at: index)
        }
    }
}

#Preview {
    PhoneListView()
        .environmentObject(PhoneDataManager())
}
