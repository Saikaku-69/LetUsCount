//
//  phoneEditManager.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/14.
//

import Foundation
import SwiftUI

class PhoneEditManager: ObservableObject {
    
    @Published var delectMessage:Bool = false
    @Published var editMessage:Bool = false
    @Published var resetMessage:Bool = false
    @Published var itemToEdit: PhoneModel?
    @Published var editingName: String = ""
    
    func startEditing(_ model: PhoneModel) {
        itemToEdit = model
        editingName = model.name
        resetMessage = true
    }
    
}
