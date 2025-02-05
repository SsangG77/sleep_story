//
//  SleepStoryCard.swift
//  SleepStory
//
//  Created by 차상진 on 1/23/25.
//

import SwiftUI



// 수면 스토리 카드 뷰
struct SleepStoryCard: View {
    let sleepData: SleepData
    @State private var showShareSheet = false
    @State private var cardImage: UIImage?
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            
            // 카드 컨텐츠
            VStack(alignment: .leading, spacing: 15) {
//                Text(SleepStoryGenerator.generateStory(from: sleepData))
                Text(sleepData.story)
                    .font(.body)
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)  // 텍스트가 여러 줄로 표시되도록 설정
                    .lineLimit(nil)  // 줄 수 제한 해제
                
                HStack(spacing: 5) {
                    ForEach(sleepData.sleepStages, id: \.self) { stage in
                        SleepStageIndicator(stage: stage)
                    }
                }
                .padding()
            }
            .background(Color.indigo.opacity(0.1))
            .cornerRadius(15)
            .padding()
            
            // 공유 버튼
            Button(action: {
                isLoading = true
                
                DispatchQueue.main.async {
                    let shareContent = VStack(alignment: .leading, spacing: 15) {
                        Text(sleepData.story)
                            .font(.body)
                            .padding()
                        
                        HStack(spacing: 5) {
                            ForEach(sleepData.sleepStages, id: \.self) { stage in
                                SleepStageIndicator(stage: stage)
                            }
                        }
                        .padding()
                    }
                    .frame(width: UIScreen.main.bounds.width - 32)
                    .background(Color.indigo.opacity(0.1))
                    .cornerRadius(15)
                    
                    let renderer = ImageRenderer(content: shareContent)
                    renderer.scale = UIScreen.main.scale
                    
                    if let image = renderer.uiImage {
                        cardImage = image
                        showShareSheet = true
                    }
                    isLoading = false
                }
            }) {
                HStack {
                    if isLoading {
                        ProgressView()
                            .tint(.white)
                            .padding(.trailing, 5)
                    } else {
                        Image(systemName: "square.and.arrow.up")
                    }
                    Text(isLoading ? "준비중..." : "스토리 공유하기")
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.indigo)
                .cornerRadius(10)
            }
            .disabled(isLoading)
        }
        .sheet(isPresented: $showShareSheet) {
            if let image = cardImage {
                ShareSheet(items: [image])
            }
        }
    }
}

