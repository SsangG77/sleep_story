//
//  SleepHistoryCard.swift
//  SleepStory
//
//  Created by 차상진 on 1/23/25.
//

import SwiftUI


struct SleepHistoryCard: View {
    let sleepData: SleepData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 날짜 표시
            Text(formatDate(sleepData.startDate))
                .font(.headline)
                .foregroundColor(.indigo)
            
            // 수면 시간
            HStack {
                Image(systemName: "clock")
                Text(calculateSleepDuration(start: sleepData.startDate, end: sleepData.endDate))
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            
            // 스토리 텍스트
            Text(sleepData.story)
                .font(.body)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(nil)
            
            // 수면 단계 인디케이터
            HStack(spacing: 3) {
                ForEach(sleepData.sleepStages, id: \.self) { stage in
                    SleepStageIndicator(stage: stage)
                        .frame(height: 130)
                }
            }
        }
        .padding()
        .background(Color.indigo.opacity(0.05))
        .cornerRadius(10)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"
        return formatter.string(from: date)
    }
    
    private func calculateSleepDuration(start: Date, end: Date) -> String {
        let duration = end.timeIntervalSince(start)
        let hours = Int(duration) / 3600
        let minutes = Int(duration) / 60 % 60
        return "\(hours)시간 \(minutes)분"
    }
}
