//
//  RecordSleepButton.swift
//  SleepStory
//
//  Created by 차상진 on 1/23/25.
//

import SwiftUI


// 수면 기록 버튼
struct RecordSleepButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("수면 기록하기")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.indigo)
                .cornerRadius(10)
        }
    }
}

