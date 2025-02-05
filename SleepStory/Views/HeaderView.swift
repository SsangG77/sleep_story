//
//  HeaderView.swift
//  SleepStory
//
//  Created by 차상진 on 1/22/25.
//

import SwiftUI

// 헤더 뷰
struct HeaderView: View {
    var body: some View {
        VStack {
            Image(systemName: "moon.stars.fill")
                .font(.system(size: 50))
                .foregroundColor(.indigo)
                .padding(.bottom, 10)
            Text("당신의 수면을 이야기로 들려드려요")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}
