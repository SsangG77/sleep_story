//
//  NoDataView.swift
//  SleepStory
//
//  Created by 차상진 on 1/23/25.
//

import SwiftUI


// 데이터 없을 때 표시할 뷰
struct NoDataView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "bed.double.fill")
                .font(.system(size: 40))
                .foregroundColor(.gray)
            Text("아직 수면 데이터가 없어요")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

#Preview {
    NoDataView()
}
