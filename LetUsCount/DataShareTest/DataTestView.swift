//
//  DataTestView.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/13.
//

import SwiftUI

struct DataTestView: View {
    @StateObject private var sampleData = SampleData()
    @State private var sheet:Bool = false
    var body: some View {
        VStack {
            Text("\(sampleData.number)")
                .font(.title)
                .padding(.bottom)
            HStack {
                Button(action: {
                    sampleData.increment()
                }) {
                    Image(systemName: "plus.circle.fill")
                    
                }
                
                Button(action: {
                    sampleData.decrement()
                }) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                }
            }.padding(.bottom)
            
            Button("Sheet") {
                sheet = true
            }
        }
        .sheet(isPresented: $sheet) {
            AnotherView(sampleData: sampleData)
                .presentationDetents([.fraction(0.5)])
        }
    }
}

#Preview {
    DataTestView()
}
