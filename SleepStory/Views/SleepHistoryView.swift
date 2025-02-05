//
//  SleepHistoryView.swift
//  SleepStory
//
//  Created by 차상진 on 1/23/25.
//

import SwiftUI


struct SleepHistoryView: View {
    @ObservedObject var sleepManager: SleepManager
    @State private var showingDeleteAlert = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sleepManager.sleepHistory) { sleepData in
                    SleepHistoryCard(sleepData: sleepData)
                }
            }
            .navigationTitle("수면 기록")
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    showingDeleteAlert = true
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        .alert("수면 기록 삭제", isPresented: $showingDeleteAlert) {
                            Button("취소", role: .cancel) { }
                            Button("삭제", role: .destructive) {
                                sleepManager.clearAllSleepHistory()
                            }
                        } message: {
                            Text("모든 수면 기록이 삭제됩니다.\n삭제된 기록은 복구할 수 없습니다.")
                        }
        }
    }
}


