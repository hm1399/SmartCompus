//
//  AppSettings.swift
//  SmartCompus
//
//  Created by Mandy on 2025/9/30.
//

import SwiftUI
import Combine

enum AppLanguage: String, CaseIterable, Identifiable {
    case english = "en"
    case traditionalChinese = "zh-Hant"
    
    var id: String { self.rawValue }
    
    var _display_name: String {
        switch self {
        case .english:
            return "English"
        case .traditionalChinese:
            return "繁體中文"
        }
    }
}

enum _LocalizationKey: Hashable {
    case home_tab
    case calendar_tab
    case service_tab
    case message_tab
    case profile_tab
    case greeting_title
    case greeting_subtitle
    case weather_description
    case weather_date
    case weather_weekday
    case today_schedule_title
    case course_one_title
    case course_two_title
    case course_three_title
    case course_status
    case quick_actions_title
    case quick_action_schedule
    case quick_action_credits
    case quick_action_library
    case quick_action_map
    case quick_action_dining
    case campus_news_title
    case news_one_title
    case news_one_description
    case news_one_time
    case news_two_title
    case news_two_description
    case news_two_time
    case profile_title
    case edit_button
    case academic_info_title
    case major_label
    case major_value
    case year_label
    case year_value
    case class_label
    case admission_year_label
    case contact_info_title
    case email_label
    case phone_label
    case modify_button
    case settings_title
    case settings_personal_info
    case settings_campus_card
    case settings_campus_card_balance
    case settings_notifications
    case settings_device_management
    case settings_privacy_security
    case settings_help_center
    case app_settings_title
    case dark_mode
    case push_notifications
    case language_title
    case logout_button
    case language_sheet_title
    case language_sheet_done
    case calendar_title
    case service_title
    case message_title
    
    // Chat related
    case chat_history
    case new_chat
    case chat_welcome
    case chat_welcome_subtitle
    case chat_input_placeholder
    case chat_history_close
    case chat_untitled
    case chat_messages_count
    case chat_no_history
    case chat_today
    case chat_yesterday
    case chat_back
}

class AppSettings: ObservableObject {
    @Published var _is_dark_mode: Bool {
        didSet {
            UserDefaults.standard.set(_is_dark_mode, forKey: "isDarkMode")
        }
    }
    
    @Published var _is_push_notification_enabled: Bool {
        didSet {
            UserDefaults.standard.set(_is_push_notification_enabled, forKey: "isPushNotificationEnabled")
        }
    }
    
    @Published var _app_language: AppLanguage {
        didSet {
            UserDefaults.standard.set(_app_language.rawValue, forKey: "appLanguage")
        }
    }
    
    static let shared = AppSettings()
    
    private init() {
        self._is_dark_mode = UserDefaults.standard.bool(forKey: "isDarkMode")
        self._is_push_notification_enabled = UserDefaults.standard.object(forKey: "isPushNotificationEnabled") as? Bool ?? true
        
        let languageCode = UserDefaults.standard.string(forKey: "appLanguage") ?? "en"
        self._app_language = AppLanguage(rawValue: languageCode) ?? .english
    }
    
    var _color_scheme: ColorScheme? {
        return _is_dark_mode ? .dark : .light
    }
    
    private let _localized_strings: [AppLanguage: [_LocalizationKey: String]] = [
        .english: [
            .home_tab: "home",
            .calendar_tab: "Calendar",
            .service_tab: "AI Assistant",
            .message_tab: "Message",
            .profile_tab: "Profile",
            .greeting_title: "Hello, Student👋",
            .greeting_subtitle: "Today is a great day!",
            .weather_description: "Ideal for going out",
            .weather_date: "September 19",
            .weather_weekday: "Friday",
            .today_schedule_title: "Today's Schedule",
            .course_one_title: "Data Structures & Algorithms",
            .course_two_title: "Machine Learning",
            .course_three_title: "Business Analytics",
            .course_status: "Ongoing",
            .quick_actions_title: "Quick Actions",
            .quick_action_schedule: "Schedule",
            .quick_action_credits: "Credits",
            .quick_action_library: "Library",
            .quick_action_map: "Campus Map",
            .quick_action_dining: "Dining",
            .campus_news_title: "Campus News",
            .news_one_title: "Innovation & Community Carnival 2025",
            .news_one_description: "CityU showcases innovation projects at D2 Place, featuring student startups...",
            .news_one_time: "2 hours ago",
            .news_two_title: "Run Run Shaw Library Extended Hours",
            .news_two_description: "Library will be open 24/7 during exam period starting next week...",
            .news_two_time: "1 day ago",
            .profile_title: "Profile",
            .edit_button: "Edit",
            .academic_info_title: "Academic Information",
            .major_label: "Major",
            .major_value: "Computer Science",
            .year_label: "Year",
            .year_value: "Year 3",
            .class_label: "Class",
            .admission_year_label: "Admission Year",
            .contact_info_title: "Contact Information",
            .email_label: "Email",
            .phone_label: "Phone Number",
            .modify_button: "Modify",
            .settings_title: "Settings",
            .settings_personal_info: "Personal Information",
            .settings_campus_card: "Campus Card",
            .settings_campus_card_balance: "Balance: $128.5",
            .settings_notifications: "Notifications",
            .settings_device_management: "Device Management",
            .settings_privacy_security: "Privacy & Security",
            .settings_help_center: "Help Center",
            .app_settings_title: "App Settings",
            .dark_mode: "Dark Mode",
            .push_notifications: "Push Notifications",
            .language_title: "Language",
            .logout_button: "Log Out",
            .language_sheet_title: "Select Language",
            .language_sheet_done: "Done",
            .calendar_title: "Calendar",
            .service_title: "AI Assistant",
            .message_title: "Message",
            
            // Chat related
            .chat_history: "Chat History",
            .new_chat: "New Chat",
            .chat_welcome: "Welcome to AI Assistant",
            .chat_welcome_subtitle: "How can I help you today?",
            .chat_input_placeholder: "Type a message...",
            .chat_history_close: "Close",
            .chat_untitled: "Untitled Conversation",
            .chat_messages_count: "messages",
            .chat_no_history: "No conversation history yet",
            .chat_today: "Today",
            .chat_yesterday: "Yesterday",
            .chat_back: "Back"
        ],
        .traditionalChinese: [
            .home_tab: "首頁",
            .calendar_tab: "日曆",
            .service_tab: "AI 助理",
            .message_tab: "訊息",
            .profile_tab: "我的",
            .greeting_title: "Hello, Student👋",
            .greeting_subtitle: "今天是美好的一天！",
            .weather_description: "適合外出",
            .weather_date: "9月19日",
            .weather_weekday: "星期五",
            .today_schedule_title: "今日課程",
            .course_one_title: "資料結構與演算法",
            .course_two_title: "機器學習",
            .course_three_title: "商業分析",
            .course_status: "進行中",
            .quick_actions_title: "快捷操作",
            .quick_action_schedule: "課表",
            .quick_action_credits: "學分",
            .quick_action_library: "圖書館",
            .quick_action_map: "校園地圖",
            .quick_action_dining: "餐飲",
            .campus_news_title: "校園資訊",
            .news_one_title: "2025創新與社區嘉年華",
            .news_one_description: "城大於D2 Place展示學生創新項目...",
            .news_one_time: "2小時前",
            .news_two_title: "邵逸夫圖書館延長開放",
            .news_two_description: "考試期間圖書館將提供24小時開放...",
            .news_two_time: "1天前",
            .profile_title: "個人中心",
            .edit_button: "編輯",
            .academic_info_title: "學籍資訊",
            .major_label: "主修",
            .major_value: "電腦科學",
            .year_label: "年級",
            .year_value: "三年級",
            .class_label: "班級",
            .admission_year_label: "入學年份",
            .contact_info_title: "聯絡方式",
            .email_label: "電郵",
            .phone_label: "電話",
            .modify_button: "修改",
            .settings_title: "設定",
            .settings_personal_info: "個人資訊",
            .settings_campus_card: "校園卡",
            .settings_campus_card_balance: "餘額：$128.5",
            .settings_notifications: "訊息通知",
            .settings_device_management: "設備管理",
            .settings_privacy_security: "隱私安全",
            .settings_help_center: "支援中心",
            .app_settings_title: "應用設定",
            .dark_mode: "深色模式",
            .push_notifications: "推送通知",
            .language_title: "語言",
            .logout_button: "退出登入",
            .language_sheet_title: "選擇語言",
            .language_sheet_done: "完成",
            .calendar_title: "日曆",
            .service_title: "AI 助理",
            .message_title: "訊息",
            
            // Chat related
            .chat_history: "聊天歷史",
            .new_chat: "新對話",
            .chat_welcome: "歡迎使用 AI 助理",
            .chat_welcome_subtitle: "今天我能幫助你什麼？",
            .chat_input_placeholder: "輸入訊息...",
            .chat_history_close: "關閉",
            .chat_untitled: "未命名對話",
            .chat_messages_count: "條訊息",
            .chat_no_history: "暫無對話歷史",
            .chat_today: "今天",
            .chat_yesterday: "昨天",
            .chat_back: "返回"
        ]
    ]
    
    func _text(_ key: _LocalizationKey) -> String {
        return _localized_strings[_app_language]?[key] ?? ""
    }
}
