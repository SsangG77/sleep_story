//
//  TodayView.swift
//  SleepStory
//
//  Created by 차상진 on 1/23/25.
//

import SwiftUI

struct TodayView: View {
    
    @ObservedObject var sleepManager: SleepManager
//    @State private var showingStory = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                // 상단 헤더
                HeaderView()
                
                ScrollView {
                    
                    // 수면 데이터 카드
                    if let latestSleep = sleepManager.latestSleepData {
                        
                        SleepStoryCard(sleepData: latestSleep)
                            .padding()
                    } else {
                        NoDataView()
                    }
                    
                    // 수면 기록 버튼
                    RecordSleepButton(action: sleepManager.recordSleep)
                    
                }
                Spacer()
            }
            .navigationTitle("수면 스토리텔러")
        }
    }
}

