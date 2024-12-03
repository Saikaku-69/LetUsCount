//
//  GrafView.swift
//  LetUsCount
//
//  Created by cmStudent on 2024/11/13.
//

import SwiftUI
import Charts

struct GraphView: View {
    
    @EnvironmentObject var taskDataManager: TaskDataManager
    @ObservedObject var taskEditManager = TaskEditManager.shared
    
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .fill(.black)
                    .aspectRatio(contentMode: .fit)
                    .frame(width:15)
                Text("物リスト")
                    .font(.system(size: 10))
            }
            if let tasks = taskDataManager.taskDataByDate[taskEditManager.selectedDate.startOfDay] {
                Chart(tasks) { item in
                    BarMark(x: .value("数量", item.name),
                            y: .value("Name", item.count),
                            width: .fixed(20))
                }
                .chartXAxis {
                    AxisMarks(values: .automatic(desiredCount: 5))
                }
            }
        }
    }
}

#Preview {
    GraphView()
        .environmentObject(TaskDataManager())
}
