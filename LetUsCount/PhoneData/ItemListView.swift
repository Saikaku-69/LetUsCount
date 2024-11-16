//
//  PhoneListView.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/13.
//

import SwiftUI

struct ItemListView: View {
    @EnvironmentObject var phoneDataManager: ItemDataManager
    @StateObject var phoneEditManager = PhoneEditManager()
    @State private var editText:String = ""
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
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
                            Button {
                                
                                phoneEditManager.itemToEdit = item
                                phoneEditManager.delectMessage = true
                                
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                            
                            Button(action: {
                                
                                phoneEditManager.startEditing(item)
                                phoneEditManager.resetMessage = true
                                
                            }) {
                                Image(systemName: "pencil")
                            }
                            .tint(.blue)
                        }
                    }
                    
                    //触发警告来输入文字
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
                    
                    // 入力したeditTextをphoneModelsのnameに代入する
                    phoneDataManager.addModel(name: editText)
                    phoneEditManager.editMessage = false
                    editText = ""
                    
                }) {
                    Text("確定")
                }
                Button("キャンセル", role: .cancel) {
                    
                    phoneEditManager.editMessage = false
                    editText = ""
                }
                
            }
        }
        .alert("修正してください", isPresented: $phoneEditManager.resetMessage) {
            TextField("名称",text: $phoneEditManager.editingName)
            Button("確定") {
                if let itemToEdit = phoneEditManager.itemToEdit {
                    phoneDataManager.updateModelById(id: itemToEdit.id, newName: phoneEditManager.editingName)
                    phoneEditManager.resetMessage = false
                    phoneEditManager.itemToEdit = nil
                    phoneEditManager.editingName = ""
                }
            }
            Button("キャンセル", role: .cancel) {
                phoneEditManager.resetMessage = false
                phoneEditManager.itemToEdit = nil
                phoneEditManager.editingName = ""
            }
        }
        .alert(isPresented: $phoneEditManager.delectMessage) {
            Alert(title: Text("警告"), message: Text("削除でよろしいですか？"),
                  primaryButton: .destructive(Text("Delect"), action: {
                
                delect()
                phoneEditManager.delectMessage = false
                
            }),
                  secondaryButton: .cancel(Text("Cancel"), action: {}))
        }
    }
    
    func delect() {
        if let index = phoneDataManager.phoneModels.firstIndex(where: {$0.id == phoneEditManager.itemToEdit?.id})  {
            phoneDataManager.phoneModels.remove(at: index)
            phoneDataManager.saveData()
        }
    }
}

#Preview {
    ItemListView()
        .environmentObject(ItemDataManager())
}
