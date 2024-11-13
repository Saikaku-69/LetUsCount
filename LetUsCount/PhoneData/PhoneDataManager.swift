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
    let name:String
    var count: Int = 0
}

class PhoneDataManager:ObservableObject {
    @Published var phoneModels: [PhoneModel] = []
    
    init() {
        loadData()
    }
    
    func loadData() {
        phoneModels = [
            PhoneModel(name: "iPhone XR", count: UserDefaults.standard.integer(forKey: "iPhone XR_count")),
            PhoneModel(name: "iPhone 11", count: UserDefaults.standard.integer(forKey: "iPhone 11_count")),
            PhoneModel(name: "iPhone 12", count: UserDefaults.standard.integer(forKey: "iPhone 12_count")),
            PhoneModel(name: "iPhone 13", count: UserDefaults.standard.integer(forKey: "iPhone 13_count"))
        ]
    }
    
    func saveData() {
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
