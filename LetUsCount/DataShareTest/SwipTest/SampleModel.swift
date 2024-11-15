//
//  SampleModel.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/14.
//

import Foundation

struct SampleModel:Identifiable {
    
    let id = UUID()
    var name: String
    
}

class SampleModelList:ObservableObject {
    
    @Published var sampleModelList: [SampleModel] = []
    
    func addSampleModel(name: String) {
        let newSampleModel = SampleModel(name: name)
        sampleModelList.append(newSampleModel)
    }
    
    func updateAddSampleModel(at index: Int, with name: String) {
        guard index >= 0 && index < sampleModelList.count else { return }
        sampleModelList[index].name = name
    }
}
