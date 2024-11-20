//
//  PhoneListView.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/13.
//

import SwiftUI

struct PhoneListView: View {
    @EnvironmentObject var taskDataManager: TaskDataManager
    @StateObject var phoneEditManager = PhoneEditManager()
    @State private var editText:String = ""
    
    var body: some View {
        VStack {
            DatePicker("Select a date", selection: $phoneEditManager.selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
            
            HStack {
                List {
                    if let tasks = taskDataManager.taskDataByDate[phoneEditManager.selectedDate] {
                        ForEach (tasks, id: \.id) { item in
                            HStack {
                                Text(item.name)
                                Spacer()
                                
                                Button(action: {
                                    taskDataManager.taskIncrement(for: item, date: phoneEditManager.selectedDate)
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.blue)
                                }
                                .buttonStyle(PlainButtonStyle()) //禁止选择整行
                                
                                Text("\(item.count)")
                                    .frame(width: 50)
                                
                                Button(action: {
                                    taskDataManager.taskDecrement(for: item, date: phoneEditManager.selectedDate)
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
                    } else {
                        Text("No tasks available for this date.")
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
                    taskDataManager.addModel(name: editText, date: phoneEditManager.selectedDate)
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
        .onAppear() {
            let calendar = Calendar.current
            let normalizedSelectedDate = calendar.startOfDay(for: phoneEditManager.selectedDate)
//            print("Normalized selected date: \(normalizedSelectedDate)")
//            print("Available keys in taskDataByDate: \(taskDataManager.taskDataByDate.keys)")
        
            let normalizedSelectedDateString = DateFormatter.yyyyMMdd.string(from: normalizedSelectedDate)
            print("Normalized selected date string: \(normalizedSelectedDateString)")

            let availableKeys = taskDataManager.taskDataByDate.keys.map {
                DateFormatter.yyyyMMdd.string(from: $0)
            }
            print("Available keys as strings: \(availableKeys)")

            if availableKeys.contains(normalizedSelectedDateString) {
                print("Match found!")
            } else {
                print("No match found.")
            }
        }
        .alert("修正してください", isPresented: $phoneEditManager.resetMessage) {
            TextField("名称",text: $phoneEditManager.editingName)
            Button("確定") {
                if let itemToEdit = phoneEditManager.itemToEdit {
                    taskDataManager.updateModelById(id: itemToEdit.id, newName: phoneEditManager.editingName, date: phoneEditManager.selectedDate)
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
                
                delete()
                phoneEditManager.delectMessage = false
                
            }),
                  secondaryButton: .cancel(Text("Cancel"), action: {}))
        }
    }
    
    func delete() {
        guard let itemToDelete = phoneEditManager.itemToEdit else {
            return
        }
        
        let selectedDate = phoneEditManager.selectedDate
        
        if var tasksForDate = taskDataManager.taskDataByDate[selectedDate] {
            tasksForDate.removeAll { $0.id == itemToDelete.id }
            
            if tasksForDate.isEmpty {
                taskDataManager.taskDataByDate.removeValue(forKey: selectedDate)
            } else {
                taskDataManager.taskDataByDate[selectedDate] = tasksForDate
            }
            
            taskDataManager.saveData()
            
            phoneEditManager.itemToEdit = nil
        }
    }
}

#Preview {
    PhoneListView()
        .environmentObject(TaskDataManager())
}
