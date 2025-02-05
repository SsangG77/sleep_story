//
//  SleepStoryApp.swift
//  SleepStory
//
//  Created by 차상진 on 1/22/25.
//

import SwiftUI
import SwiftData

@main
struct SleepStoryApp: App {
    
    let sleepManager = SleepManager()

    init() {
        sleepManager.requestAuthorization()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
    }
}

#Preview {
    ContentView()
}
