//
//  SleepManager.swift
//  SleepStory
//
//  Created by 차상진 on 1/23/25.
//

import Foundation
import HealthKit



// 수면 데이터 관리자
class SleepManager: ObservableObject {
    @Published var latestSleepData: SleepData?
    @Published var sleepHistory: [SleepData] = []
    private let healthStore = HKHealthStore()
    
    init() {
        loadSleepHistory()  // 초기화 시 저장된 데이터 로드
    }
    
    // 수면 기록 저장 함수
    func recordSleep() {
        
        print("[\(#function)] recordSleep 시작")
        
//        let sampleSleepStages: [SleepStage] = [.light, .deep, .rem, .deep, .light, .rem, .awake, .deep, .light, .rem, .deep, .awake, .light]
//        let startDate = Date().addingTimeInterval(-28800) // 8시간 전
//        let endDate = Date()
        
        // 스토리를 한 번만 생성
        let generatedStory = SleepStoryGenerator.generateStory(from: SleepData(
            startDate: latestSleepData?.startDate ?? Date().addingTimeInterval(-28800),
            endDate: latestSleepData?.endDate ?? Date(),
            sleepStages: latestSleepData!.sleepStages,
            story: ""
        ))
        
        let newSleepData = SleepData(
            startDate: latestSleepData!.startDate,
            endDate: latestSleepData!.endDate,
            sleepStages: latestSleepData!.sleepStages,
            story: generatedStory  // 생성된 스토리를 직접 사용
        )
        
        DispatchQueue.main.async {
            self.latestSleepData = newSleepData
        
            self.sleepHistory.insert(newSleepData, at: 0)
            self.saveSleepHistory()
        }
    }
    
    // UserDefaults에 데이터 저장
    private func saveSleepHistory() {
        if let encoded = try? JSONEncoder().encode(sleepHistory) {
            UserDefaults.standard.set(encoded, forKey: "SleepHistory")
        }
    }
    
    // UserDefaults에서 데이터 로드
    private func loadSleepHistory() {
        if let data = UserDefaults.standard.data(forKey: "SleepHistory"),
           let decoded = try? JSONDecoder().decode([SleepData].self, from: data) {
            self.sleepHistory = decoded
            self.latestSleepData = decoded.first
        }
    }
    
    func clearAllSleepHistory() {
            sleepHistory.removeAll()
            latestSleepData = nil
//            saveSleepHistory()
        }
    
    func requestAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else { return }
        
        let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        
        healthStore.requestAuthorization(toShare: [], read: [sleepType]) { [weak self] success, error in
            if success {
                print("HealthKit 권한 획득 성공")
//                DispatchQueue.main.async {
                    self?.fetchLatestSleepData()
//                }
            } else {
                print("HealthKit 권한 획득 실패: \(error?.localizedDescription ?? "알 수 없는 오류")")
            }
        }
    }
    
    //수면 데이터 가져오기
    private func fetchLatestSleepData() {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else { return }
        
        let calendar = Calendar.current
        let endDate = Date()
        let startDate = calendar.date(byAdding: .day, value: -1, to: endDate)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)
        
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { [weak self] (query, samples, error) in
            if let error = error {
                print("Error fetching sleep data: \(error.localizedDescription)")
                return
            }
            
            guard let samples = samples as? [HKCategorySample] else { 
                print("No sleep samples found")
                return 
            }
            
            print("총 수면 기록 수: \(samples.count)")
            
            var sleepStages: [SleepStage] = []
            
            for sample in samples {
                print("\n=== 수면 기록 상세 ===")
                print("원본 값: \(sample.value)")
                print("시작 시간: \(sample.startDate)")
                print("종료 시간: \(sample.endDate)")
                print("지속 시간: \(sample.endDate.timeIntervalSince(sample.startDate) / 3600)시간")
                
                let stage: SleepStage = {
                    switch sample.value {
                    case HKCategoryValueSleepAnalysis.inBed.rawValue:
                        return .light
                    case HKCategoryValueSleepAnalysis.asleep.rawValue:
                        return .deep
                    case HKCategoryValueSleepAnalysis.awake.rawValue:
                        return .awake
                    case HKCategoryValueSleepAnalysis.asleepREM.rawValue:
                        return .rem
                    default:
                        return .awake
                    }
                }()
                
                print("변환된 수면 단계: \(stage)")
                sleepStages.append(stage)
            }
            
            // 전체 수면 시작 시간과 끝 시간을 Date 타입으로 구하기
            let earliestStartDate = samples.map { $0.startDate }.min() ?? Date.distantPast
            let latestEndDate = samples.map { $0.endDate }.max() ?? Date.distantFuture

            //실제 수면 데이터
            let realSleepData = SleepData(
                startDate: earliestStartDate,
                endDate: latestEndDate,
                sleepStages: sleepStages,
                story: SleepStoryGenerator.generateStory(from: sleepStages)
            )
            
            
            
            // 예시 데이터로 대체
            let sampleSleepData = SleepData(
                startDate: Date().addingTimeInterval(-28800),
                endDate: Date(),
                sleepStages: [.light, .deep, .rem, .deep, .light, .rem, .awake, .deep, .light, .rem, .deep, .awake, .light],
                story: SleepStoryGenerator.generateStory(from: [.light, .deep, .rem, .deep, .light, .rem, .awake, .deep, .light, .rem, .deep, .awake, .light])  // 스토리 생성 및 저장
            )
            
            DispatchQueue.main.async {
//                self?.latestSleepData = sampleSleepData
                self?.latestSleepData = realSleepData
                // 히스토리에 추가
                self?.sleepHistory.insert(sampleSleepData, at: 0)
                self?.saveSleepHistory()  // 데이터 저장
                
            }
        }
        
        healthStore.execute(query)
    }
    
//    private func addDummyHistoryData() {
//        // 최근 7일간의 더미 데이터 생성
//        for i in 1...7 {
//            let startDate = Date().addingTimeInterval(Double(-i * 86400))
//            let endDate = startDate.addingTimeInterval(28800)
//            let sleepStages: [SleepStage] = [.light, .deep, .rem, .deep, .light, .rem, .awake, .deep, .light]
//            let sleepData = SleepData(
//                startDate: startDate,
//                endDate: endDate,
//                sleepStages: sleepStages,
//                story: SleepStoryGenerator.generateStory(from: sleepStages)  // 스토리 생성 및 저장
//            )
//            
//            DispatchQueue.main.async {
//                if !self.sleepHistory.contains(where: { $0.startDate == sleepData.startDate }) {
//                    self.sleepHistory.append(sleepData)
//                }
//            }
//        }
//        
//        // 날짜순으로 정렬 및 저장
//        DispatchQueue.main.async {
//            self.sleepHistory.sort { $0.startDate > $1.startDate }
//            self.saveSleepHistory()  // 데이터 저장
//        }
//    }
    
    func saveCurrentSleepStory() {
        guard let currentSleepData = latestSleepData else { return }
        
        // 현재 표시된 데이터를 그대로 저장
        if let index = sleepHistory.firstIndex(where: {
            Calendar.current.isDate($0.startDate, inSameDayAs: currentSleepData.startDate)
        }) {
            sleepHistory.remove(at: index)
        }
        
        sleepHistory.insert(currentSleepData, at: 0)  // 현재 데이터를 그대로 저장
        saveSleepHistory()
    }
}
