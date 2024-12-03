//
//  PhoneData.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/13.
//

import Foundation
import SwiftUI

struct TaskModel: Identifiable,Hashable,Codable {
    //Phone模型的类型
    //用作字典键或集合元素需要遵循Hashable协议
    var id = UUID()
    var name:String
    var count: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id, name, count
    }
}

class TaskDataManager:ObservableObject {
    @Published var taskDataByDate: [Date: [TaskModel]] = [:] {
        didSet {
            saveData()
        }
    }
    
    init() {
        loadData()
    }
    
    func saveData() {
        let encodableData: [String: [TaskModel]] = taskDataByDate.reduce(into: [:]) { result, element in
            let dateString = DateFormatter.yyyyMMdd.string(from: element.key.startOfDay) // 使用 startOfDay 确保没有时间部分
            result[dateString] = element.value
            print("Data before encoding: \(taskDataByDate)")
        }
        
        do {
            let encodedData = try JSONEncoder().encode(encodableData)
            UserDefaults.standard.set(encodedData, forKey: "taskDataByDate")
            print("Saved data successfully.")
        } catch {
            print("Failed to encode data for UserDefaults: \(error.localizedDescription)")
        }
    }
    
    func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: "taskDataByDate") {
            do {
                // 解码数据
                let decodedData = try JSONDecoder().decode([String: [TaskModel]].self, from: savedData)
                
                // 将 decodedData 的日期字符串转回 Date，并且使用 startOfDay 进行统一
                taskDataByDate = decodedData.reduce(into: [:]) { result, element in
                    if let date = DateFormatter.yyyyMMdd.date(from: element.key)?.startOfDay {
                        result[date] = element.value
                        print("Decoded data: \(decodedData)")
                    }
                }
                
                print("Loaded data successfully: \(taskDataByDate)")
            } catch {
                print("Failed to decode data from UserDefaults: \(error.localizedDescription)")
            }
        } else {
            print("No data found in UserDefaults.")
        }
    }
    
    func addModel(name: String, date: Date) {
        let normalizedDate = Calendar.current.startOfDay(for: date) // 规范化日期
        let newModel = TaskModel(name: name, count: 0)
        
        if taskDataByDate[normalizedDate] != nil {
            taskDataByDate[normalizedDate]?.append(newModel)
        } else {
            taskDataByDate[normalizedDate] = [newModel]
        }
        
        saveData()
    }
    
    func updateModelById(id: UUID, newName: String, newCount: Int? = nil, date: Date) {
        // 匹配日期
        if var tasks = taskDataByDate[date],
           let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks[index].name = newName
            if let count = newCount {
                tasks[index].count = count
            }
            taskDataByDate[date] = tasks
            saveData()
        }
    }
    
    
    func taskIncrement(for item: TaskModel, date: Date) {
        if var tasks = taskDataByDate[date],
           let index = tasks.firstIndex(where: { $0.id == item.id }) {
            tasks[index].count += 1
            taskDataByDate[date] = tasks
            saveData()
        }
    }
    
    func taskDecrement(for item: TaskModel, date: Date) {
        if var tasks = taskDataByDate[date],
           let index = tasks.firstIndex(where: { $0.id == item.id}) {
            if tasks[index].count > 0 {
                tasks[index].count -= 1
                taskDataByDate[date] = tasks
                saveData()
            }
        }
    }
}

extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
extension Date {
    var startOfDay: Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: self)
    }
}
