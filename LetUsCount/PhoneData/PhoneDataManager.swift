//
//  PhoneData.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/13.
//

import Foundation
import SwiftUI

class PhoneDataManager:ObservableObject {
    @Published var phoneCount:Int = 0
    
    func phoneIncrement() {
        phoneCount += 1
    }
    
    func phoneDecrement() {
        if phoneCount > 0 {
            phoneCount -= 1
        }
    }
}
