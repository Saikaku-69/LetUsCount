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
                    .fill(.blue)
                    .aspectRatio(contentMode: .fit)
                    .frame(width:15)
                Text("数量")
                    .font(.system(size: 10))
            }
            if let tasks = taskDataManager.taskDataByDate[taskEditManager.selectedDate.startOfDay] {
                Chart(tasks) { item in
                    BarMark(x: .value("Name", item.name),
                            y: .value("数量", item.count),
                            width: .fixed(20))
                    .annotation {
                        Text("\(item.count)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .chartXAxis {
                    AxisMarks(values: .automatic(desiredCount: 5))
                }
//                .chartYScale(domain: 0...10)
                .chartPlotStyle { plotArea in
                    plotArea.background(.gray.opacity(0.1))
                }
            }
        }
    }
}

#Preview {
    GraphView()
        .environmentObject(TaskDataManager())
}
