
//
//  ContentView.swift
//  SleepStory
//
//  Created by 차상진 on 1/22/25.
//

import SwiftUI




// 메인 뷰
struct ContentView: View {
   
    @StateObject private var sleepManager = SleepManager()
    
    var body: some View {
        TabView {
            TodayView(sleepManager: sleepManager)
                .tabItem {
                    Label("오늘", systemImage: "moon.stars.fill")
                }
            
            SleepHistoryView(sleepManager: sleepManager)
                .tabItem {
                    Label("기록", systemImage: "list.bullet.clipboard.fill")
                }
        }
        .accentColor(.indigo)
    }
}






// ShareSheet를 위한 UIViewControllerRepresentable
struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: items,
            applicationActivities: nil
        )
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}


