//
//  AnotherView.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/13.
//

import SwiftUI

struct AnotherView: View {
    @ObservedObject var sampleData: SampleData
    var body: some View {
        Button(action: {
            print ("\(sampleData.number)")
            sampleData.increment()
            print ("\(sampleData.number)")
        }) {
            Text("Increment")
        }
    }
}

#Preview {
    AnotherView(sampleData: SampleData())
}
