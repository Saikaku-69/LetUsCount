//
//  PhoneData.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/13.
//

import Foundation
import SwiftUI

struct PhoneModel: Identifiable,Hashable {
    //Phone模型的类型
    //用作字典键或集合元素需要遵循Hashable协议
    let id = UUID()
    var name:String
    var count: Int = 0
}

class PhoneDataManager:ObservableObject {
    @Published var phoneModels: [PhoneModel] = []
    
    init() {
        loadData()
    }
    
    func updateModel(at index: Int, with name: String) {
        guard index >= 0 && index < phoneModels.count else { return }
        phoneModels[index].name = name
    }
    
    func addModel(name: String, count: Int = 0) {
        let count = UserDefaults.standard.integer(forKey: "\(name)_count")
        let newModel = PhoneModel(name: name, count: count)
        phoneModels.append(newModel)
        saveData()
    }
    
    func loadData() {
        phoneModels = []
        let savedNames = UserDefaults.standard.stringArray(forKey: "savedPhoneNames") ?? []
        for name in savedNames {
            let count = UserDefaults.standard.integer(forKey: "\(name)_count")
            let model = PhoneModel(name: name, count: count)
            phoneModels.append(model)
        }
    }
    
    func saveData() {
        UserDefaults.standard.set(phoneModels.map { $0.name }, forKey: "savedPhoneNames")
        for phone in phoneModels {
            UserDefaults.standard.set(phone.count, forKey: "\(phone.name)_count")
        }
    }
    
    
    func phoneIncrement(for item: PhoneModel) {
        //where闭包为了找到匹配的元素
        if let index = phoneModels.firstIndex(where: { $0.id == item.id }) {
            phoneModels[index].count += 1
            saveData()
        }
    }
    
    func phoneDecrement(for item: PhoneModel) {
        if let index = phoneModels.firstIndex(where: { $0.id == item.id}) {
            if phoneModels[index].count > 0 {
                phoneModels[index].count -= 1
                saveData()
            }
        }
    }
}
