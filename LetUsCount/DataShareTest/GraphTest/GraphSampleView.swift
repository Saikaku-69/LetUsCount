//
//  GraphSampleView.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/12/03.
//

import SwiftUI
import Charts


//struct SalesData: Identifiable {
//    let id = UUID()
//    let name: String
//    let sales: Double
//}
//
//let data: [SalesData] = [
//    SalesData(name: "iPhone", sales: 1000000),
//    SalesData(name: "iPad", sales: 500000),
//    SalesData(name: "MacBook", sales: 750000),
//    SalesData(name: "AirPods", sales: 1200000),
//    SalesData(name: "Apple Watch", sales: 600000)
//]


struct GraphSampleView: View {
    
    @EnvironmentObject var taskDataManager: TaskDataManager
    @ObservedObject var taskEditManager = TaskEditManager.shared
    
    
    var body: some View {
        if let tasks = taskDataManager.taskDataByDate[taskEditManager.selectedDate.startOfDay] {
            
            Chart(tasks) { item in
                BarMark(x: .value("数量", item.name),
                        y: .value("Name", item.count))
            }
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 5))
            }
            
        }
    }
}

#Preview {
    GraphSampleView()
        .environmentObject(TaskDataManager())
}
