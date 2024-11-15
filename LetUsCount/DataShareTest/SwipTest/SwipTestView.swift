//
//  SwipTestView.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/14.
//

import SwiftUI

struct SwipTestView: View {
    @StateObject var sampleModelList = SampleModelList()
    
    @State private var sampleEditText:String = ""
    @State private var checkEdit:Bool = false
    @State private var delectMessage:Bool = false
    @State private var itemIndex: Int?
    var body: some View {
        List {
            ForEach(sampleModelList.sampleModelList.indices,id: \.self) { index in
                
                let item = sampleModelList.sampleModelList[index]
                Text(item.name)
                    .swipeActions {
                        
                        Button(role: .destructive) {
                            
                            itemIndex = index
                            delectMessage = true
                            
                        } label: {
                            Image(systemName: "trash")
                        }
                        
                        Button(action: {
                            
                            checkEdit = true
                            print (item.name)
                        }) {
                            Image(systemName: "pencil")
                        }
                        .tint(.blue)
                    }
            }
            
            Button(action: {
                //添加手机型号
                //添加配列
                sampleModelList.addSampleModel(name: sampleEditText)
//                sampleEditText = ""
//                print ("行を追加後：\(sampleEditText)")
                sampleModelList.updateAddSampleModel(at: 0, with: sampleEditText)
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.green)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .alert("入力してください",isPresented: $checkEdit) {
            TextField("Phone",text: $sampleEditText)
            Button(action: {
                if let index = itemIndex {
                    sampleModelList.updateAddSampleModel(at: index, with: sampleEditText)
                }
                
//                sampleEditText = ""
                print ("入力後：\(sampleEditText)")
            }, label: {
                Text("OK")
            })
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
        if let index = itemIndex {
            sampleModelList.sampleModelList.remove(at: index)
        }
    }
}

#Preview {
    SwipTestView()
}
