//
//  SampleData.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/13.
//

import Foundation
import SwiftUI

class SampleData: ObservableObject {
    @Published var number: Int = 0
    
    func increment() {
        number += 1
    }
    
    func decrement() {
        number -= 1
    }
}
