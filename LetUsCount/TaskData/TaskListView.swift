//
//  PhoneListView.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/13.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var taskDataManager: TaskDataManager
    @StateObject var taskEditManager = TaskEditManager.shared
    @State private var editText:String = ""
    var body: some View {
        VStack {
            DatePicker("Select a date", selection: $taskEditManager.selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
            
            
            HStack {
                Spacer()
                Image(systemName: "list.bullet.clipboard")
                Text("買い物リスト")
                
                Spacer()
                Button(action: {
                    //リセットボタン
                    deleteOfDay()
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .font(.system(size:15))
                }
                .padding(.trailing)
            }
            .font(.system(size:30))
            .fontWeight(.bold)
            
            HStack {
                List {
                    if let tasks = taskDataManager.taskDataByDate[taskEditManager.selectedDate.startOfDay] {
                        ForEach (tasks, id: \.id) { item in
                            HStack {
                                Text(item.name)
                                Spacer()
                                
                                Button(action: {
                                    taskDataManager.taskDecrement(for: item, date: taskEditManager.selectedDate.startOfDay)
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(PlainButtonStyle()) //禁止选择整行
                                
                                Text("\(item.count)")
                                    .frame(width: 50)
                                
                                
                                Button(action: {
                                    taskDataManager.taskIncrement(for: item, date: taskEditManager.selectedDate.startOfDay)
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.blue)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .swipeActions {
                                Button {
                                    
                                    taskEditManager.itemToEdit = item
                                    taskEditManager.delectMessage = true
                                    
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)
                                
                                Button(action: {
                                    
                                    taskEditManager.startEditing(item)
                                    taskEditManager.resetMessage = true
                                    
                                }) {
                                    Image(systemName: "pencil")
                                }
                                .tint(.blue)
                            }
                        }
                    }
                    
                    //触发警告来输入文字
                    Button(action: {
                        
                        taskEditManager.editMessage = true
                        
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.green)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                }
            }
            .alert("入力してください", isPresented: $taskEditManager.editMessage) {
                TextField("名称",text: $editText)
                Button(action: {
                    
                    // 入力したeditTextをphoneModelsのnameに代入する
                    taskDataManager.addModel(name: editText, date: taskEditManager.selectedDate.startOfDay)
                    taskEditManager.editMessage = false
                    editText = ""
                    
                }) {
                    Text("確定")
                }
                Button("キャンセル", role: .cancel) {
                    
                    taskEditManager.editMessage = false
                    editText = ""
                }
                
            }
        }
        .alert("修正してください", isPresented: $taskEditManager.resetMessage) {
            TextField("名称",text: $taskEditManager.editingName)
            Button("確定") {
                if let itemToEdit = taskEditManager.itemToEdit {
                    taskDataManager.updateModelById(id: itemToEdit.id, newName: taskEditManager.editingName, date: taskEditManager.selectedDate.startOfDay)
                    taskEditManager.resetMessage = false
                    taskEditManager.itemToEdit = nil
                    taskEditManager.editingName = ""
                }
            }
            Button("キャンセル", role: .cancel) {
                taskEditManager.resetMessage = false
                taskEditManager.itemToEdit = nil
                taskEditManager.editingName = ""
            }
        }
        .alert(isPresented: $taskEditManager.delectMessage) {
            Alert(title: Text("警告"), message: Text("削除でよろしいですか？"),
                  primaryButton: .destructive(Text("Delect"), action: {
                
                delete()
                taskEditManager.delectMessage = false
                
            }),
                  secondaryButton: .cancel(Text("Cancel"), action: {}))
        }
    }
    
    func delete() {
        guard let itemToDelete = taskEditManager.itemToEdit else {
            return
        }
        
        let selectedDate = taskEditManager.selectedDate.startOfDay
        
        if var tasksForDate = taskDataManager.taskDataByDate[selectedDate] {
            tasksForDate.removeAll { $0.id == itemToDelete.id }
            
            if tasksForDate.isEmpty {
                taskDataManager.taskDataByDate.removeValue(forKey: selectedDate)
            } else {
                taskDataManager.taskDataByDate[selectedDate] = tasksForDate
            }
            
            taskDataManager.saveData()
            
            taskEditManager.itemToEdit = nil
        }
    }
    func deleteOfDay() {
        let selectedDate = taskEditManager.selectedDate.startOfDay
        taskDataManager.taskDataByDate.removeValue(forKey: selectedDate)
        taskDataManager.saveData()
    }
}

#Preview {
    TaskListView()
        .environmentObject(TaskDataManager())
}
