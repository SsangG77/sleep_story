//
//  SleepStageIndicator.swift
//  SleepStory
//
//  Created by 차상진 on 1/23/25.
//

import SwiftUI


// 수면 단계 표시 뷰
struct SleepStageIndicator: View {
    let stage: SleepStage
    //rem ,deep, light, awake
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 15, height: stage == .rem ? 50 : stage == .deep ? 80 : stage == .light ? 100 : 120)
            .foregroundColor(backgroundColor)
    }
    
    private var backgroundColor: Color {
        switch stage {
        case .awake: return .gray
        case .light: return .blue
        case .deep: return .indigo
        case .rem: return .purple
        }
    }
}

#Preview {
    SleepStageIndicator(stage: .rem)
}
