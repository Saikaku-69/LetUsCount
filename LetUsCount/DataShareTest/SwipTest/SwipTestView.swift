//
//  SwipTestView.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/14.
//

import SwiftUI

struct SwipTestView: View {
    
    @State private var sampleArray: [Int] = []
    
    @State private var sampleEditText:String = ""
    @State private var checkEdit:Bool = false
    @State private var delectMessage:Bool = false
    @State private var itemIndex: Int?
    var body: some View {
        List {
            ForEach(sampleArray,id: \.self) { item in
                Text("Phone \(sampleEditText)")
                    .swipeActions {
                        
                        Button(role: .destructive) {
                            
                            itemIndex = item
                            delectMessage = true
                            
                        } label: {
                            Image(systemName: "trash")
                        }
                        
                        Button(action: {
                            
                            checkEdit = true
                            
                        }) {
                            Image(systemName: "pencil")
                        }
                        .tint(.blue)
                    }
            }
            
            Button(action: {
                //添加手机型号
                //添加配列
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.green)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .alert(isPresented: $checkEdit) {
            Alert(
                title: Text("ケータイの型"),
                message: Text("入力してください"),
                primaryButton: (.default(Text("OK"), action: {})),
                secondaryButton: .cancel(Text("Cancel"), action: {})
            )
        }
        .alert(isPresented: $delectMessage) {
            Alert(
                title: Text("警告"),
                message: Text("削除でよろしいですか？"),
                primaryButton: (.default(Text("Delect"), action: {
                    
                    letDelect()
                    
                })),
                secondaryButton: .cancel(Text("Cancel"), action: {
                    
                })
            )
        }
    }
    private func letDelect() {
        //check array
        if let index = sampleArray.firstIndex(of: itemIndex!)  {
            sampleArray.remove(at: index)
        }
    }
}

#Preview {
    SwipTestView()
}
