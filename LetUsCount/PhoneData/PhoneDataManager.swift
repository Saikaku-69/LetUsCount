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
    @Published var phoneModel: [PhoneModel]
    
    init() {
        self.phoneModel = [
            PhoneModel(name: "iPhoneXR"),
            PhoneModel(name: "iPhone11"),
            PhoneModel(name: "iPhone12"),
            PhoneModel(name: "iPhone13")
        ]
    }
    
    func phoneIncrement(for item: PhoneModel) {
        //where闭包为了找到匹配的元素
        if let index = phoneModel.firstIndex(where: { $0.id == item.id }) {
            phoneModel[index].count += 1
        }
    }
    
    func phoneDecrement(for item: PhoneModel) {
        if let index = phoneModel.firstIndex(where: { $0.id == item.id}) {
            if phoneModel[index].count > 0 {
                phoneModel[index].count -= 1
            }
        }
    }
}
