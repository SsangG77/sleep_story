//
//  SleepStoryGenerator.swift
//  SleepStory
//
//  Created by 차상진 on 1/23/25.
//

import Foundation





// SleepStoryGenerator 수정
class SleepStoryGenerator {
    // StoryTemplate 구조체를 클래스 내부로 이동
    struct StoryTemplate {
        let intro: String
        let deepSleepStory: String
        let remSleepStory: String
    }
    
    private static let templates: [StoryTemplate] = [
        StoryTemplate(
            intro: "🌙 어젯밤의 수면 모험 이야기",
            deepSleepStory: "신비로운 해저 도시를 탐험했고",
            remSleepStory: "환상적인 달나라 여행을 다녀왔어요"
        ),
        StoryTemplate(
            intro: "✨ 당신의 꿈나라 여행기",
            deepSleepStory: "고요한 숲속에서 휴식을 취했고",
            remSleepStory: "구름 위 성에서 파티에 참석했어요"
        ),
        StoryTemplate(
            intro: "💫 밤하늘의 별들이 들려주는 이야기",
            deepSleepStory: "신비한 오로라 아래서 명상을 하였고",
            remSleepStory: "은하수를 타고 우주 여행을 했어요"
        ),
        StoryTemplate(
            intro: "🎭 꿈속의 판타지 모험",
            deepSleepStory: "마법의 정원에서 휴식을 취했고",
            remSleepStory: "용을 타고 하늘을 날아다녔어요"
        ),
        StoryTemplate(
            intro: "🌈 당신의 꿈꾸는 시간",
            deepSleepStory: "비밀스러운 동굴에서 보물을 찾았고",
            remSleepStory: "타임머신을 타고 시간 여행을 했어요"
        ),
        StoryTemplate(
            intro: "🏰 마법의 성에서의 하룻밤",
            deepSleepStory: "황금빛 호수에서 수영을 했고",
            remSleepStory: "페가수스와 함께 별자리를 만들었어요"
        ),
        StoryTemplate(
            intro: "🌺 꽃피는 꿈나라에서",
            deepSleepStory: "향기로운 꽃밭에서 낮잠을 잤고",
            remSleepStory: "나비와 함께 무지개를 건넜어요"
        ),
        StoryTemplate(
            intro: "🎪 환상의 서커스",
            deepSleepStory: "공중그네를 타고 휴식을 취했고",
            remSleepStory: "마법사와 함께 공연을 펼쳤어요"
        ),
        StoryTemplate(
            intro: "🌊 심해의 비밀 이야기",
            deepSleepStory: "인어공주의 성에서 음악회를 즐겼고",
            remSleepStory: "돌고래와 함께 춤을 추었어요"
        ),
        StoryTemplate(
            intro: "🎨 예술가의 꿈",
            deepSleepStory: "무지개 물감으로 그림을 그렸고",
            remSleepStory: "상상 속 걸작들이 살아움직였어요"
        ),
        StoryTemplate(
            intro: "🎵 꿈속의 콘서트",
            deepSleepStory: "천사들의 하모니를 들으며 쉬었고",
            remSleepStory: "구름 위에서 오케스트라를 지휘했어요"
        ),
        StoryTemplate(
            intro: "🌸 벚꽃 축제의 밤",
            deepSleepStory: "벚꽃비 아래서 차를 마시며 쉬었고",
            remSleepStory: "꽃잎을 타고 하늘을 날아다녔어요"
        ),
        StoryTemplate(
            intro: "🏖 열대섬의 휴양",
            deepSleepStory: "크리스탈 동굴에서 명상을 했고",
            remSleepStory: "야자수 위에서 별을 따왔어요"
        ),
        StoryTemplate(
            intro: "🎡 꿈나라 놀이공원",
            deepSleepStory: "솜사탕 구름 위에서 낮잠을 잤고",
            remSleepStory: "회전목마를 타고 우주를 여행했어요"
        ),
        StoryTemplate(
            intro: "❄️ 겨울왕국의 밤",
            deepSleepStory: "오로라 아래 얼음성에서 휴식했고",
            remSleepStory: "눈의 요정과 함께 춤을 추었어요"
        ),
        StoryTemplate(
            intro: "🌋 신비한 화산섬에서",
            deepSleepStory: "따뜻한 온천에서 휴식을 취했고",
            remSleepStory: "불사조와 함께 일출을 보았어요"
        ),
        StoryTemplate(
            intro: "🎪 마법사의 서재에서",
            deepSleepStory: "고대 마법서로 베개를 만들어 쉬었고",
            remSleepStory: "책 속 이야기의 주인공이 되었어요"
        ),
        StoryTemplate(
            intro: "🌿 요정의 정원",
            deepSleepStory: "반딧불이 침대에서 휴식했고",
            remSleepStory: "작은 요정들과 티파티를 했어요"
        ),
        StoryTemplate(
            intro: "🎠 회전목마의 추억",
            deepSleepStory: "유니콘 등에서 낮잠을 잤고",
            remSleepStory: "무지개 다리를 건너 모험을 떠났어요"
        ),
        StoryTemplate(
            intro: "🌄 해돋이 산책",
            deepSleepStory: "구름 침대에서 휴식을 취했고",
            remSleepStory: "새벽별과 함께 춤을 추었어요"
        )
    ]
    
    private static let sleepQualityDescriptions: [String] = [
        "평화로운",
        "달콤한",
        "포근한",
        "안락한",
        "편안한",
        "즐거운",
        "행복한",
        "설레는",
        "신비로운",
        "황홀한",
        "마법같은",
        "환상적인",
        "아름다운",
        "특별한",
        "감동적인",
        "놀라운",
        "따뜻한",
        "부드러운",
        "로맨틱한",
        "꿈같은"
    ]
    
    private static func getTimeDescription(_ hours: Int) -> String {
        let timeDescriptions = [
            "\(hours)시간 동안",
            "\(hours)시간이라는 시간 동안",
            "약 \(hours)시간에 걸쳐",
            "\(hours)시간이나",
            "소중한 \(hours)시간",
            "특별한 \(hours)시간",
            "마법 같은 \(hours)시간",
            "꿈같은 \(hours)시간 동안",
            "행복한 \(hours)시간",
            "환상적인 \(hours)시간"
        ]
        return timeDescriptions.randomElement() ?? "\(hours)시간 동안"
    }
    
    private static let endingPhrases = [
        "이 특별한 여행을 통해 당신의 몸과 마음이 새로워졌어요 ✨",
        "오늘도 충분한 휴식으로 에너지가 가득해졌어요 💫",
        "꿈나라에서의 모험으로 당신의 하루가 더욱 특별해질 거예요 🌟",
        "이 마법 같은 시간이 당신에게 행복한 하루를 선물할 거예요 🎁",
        "충분한 휴식으로 오늘 하루도 빛날 거예요 ⭐️"
    ]
    
    static func generateStory(from sleepData: SleepData) -> String {
        
        
        
        let duration = sleepData.endDate.timeIntervalSince(sleepData.startDate)
        let hours = Int(duration / 3600)
        let deepSleepCount = sleepData.sleepStages.filter { $0 == .deep }.count
        let remCount = sleepData.sleepStages.filter { $0 == .rem }.count
        
        let template = templates.randomElement()!
        let qualityDescription = sleepQualityDescriptions.randomElement()!
        let timeDescription = getTimeDescription(hours)
        let endingPhrase = endingPhrases.randomElement()!
        
        let mainStory = """
        
        
        당신은 \(timeDescription) \(qualityDescription) 꿈나라를 여행했어요.
        깊은 수면 동안에는 \(deepSleepCount)번의 \(template.deepSleepStory),
        렘수면 단계에서는 \(remCount)번의 \(template.remSleepStory).
        
        \(endingPhrase)
        """
        
        return template.intro + mainStory
    }
    
    static func generateStory(from stages: [SleepStage]) -> String {
        // 기존의 스토리 생성 로직
        // ... 여기에 스토리 생성 로직 구현
        return "오늘 밤에는 깊은 수면과 렘수면이 균형있게 나타났어요. 수면의 질이 좋았던 밤이에요."
    }
}
