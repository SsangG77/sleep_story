//
//  SleepData.swift
//  SleepStory
//
//  Created by 차상진 on 1/23/25.
//

import SwiftUI

// SleepData 모델 수정
struct SleepData: Identifiable, Codable {
    let id = UUID()
    let startDate: Date
    let endDate: Date
    let sleepStages: [SleepStage]
    let story: String  // 스토리 텍스트 저장을 위한 프로퍼티 추가
}

// SleepStage enum에 Codable 추가
enum SleepStage: String, Codable {
    case awake, light, deep, rem
}
