//
//  MainTabView.swift
//  SmartCompus
//
//  Created by Mandy on 2025/9/30.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var _app_settings: AppSettings
    @State private var _selected_tab = 0
    
    var body: some View {
        TabView(selection: $_selected_tab) {
            HomeView()
                .tabItem {
                    Image(systemName: _selected_tab == 0 ? "house.fill" : "house")
                    Text(_app_settings._text(.home_tab))
                }
                .tag(0)
            
            CalendarView()
                .tabItem {
                    Image(systemName: _selected_tab == 1 ? "calendar.badge.clock" : "calendar")
                    Text(_app_settings._text(.calendar_tab))
                }
                .tag(1)
            
            _AIAssistantTabWrapper(_selected_tab: $_selected_tab)
                .tabItem {
                    Image(systemName: _selected_tab == 2 ? "sparkles" : "sparkle")
                    Text(_app_settings._text(.service_tab))
                }
                .tag(2)
            
            MessageView()
                .tabItem {
                    Image(systemName: _selected_tab == 3 ? "message.fill" : "message")
                    Text(_app_settings._text(.message_tab))
                }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Image(systemName: _selected_tab == 4 ? "person.fill" : "person")
                    Text(_app_settings._text(.profile_tab))
                }
                .tag(4)
        }
        .accentColor(Color(red: 0.4, green: 0.3, blue: 0.9))
    }
}

// AI 助手包装视图
struct _AIAssistantTabWrapper: View {
    @EnvironmentObject var _app_settings: AppSettings
    @Binding var _selected_tab: Int
    
    var body: some View {
        _AIAssistantWithTabControl(selectedTab: $_selected_tab)
            .environmentObject(_app_settings)
    }
}

// 带标签页控制的 AI 助手
struct _AIAssistantWithTabControl: View {
    @EnvironmentObject var _app_settings: AppSettings
    @Binding var selectedTab: Int
    @State private var _is_presented = true
    
    var body: some View {
        AIAssistantView(isPresented: $_is_presented)
            .environmentObject(_app_settings)
            .onChange(of: _is_presented) {
                if !_is_presented {
                    selectedTab = 0
                }
            }
    }
}

#Preview {
    MainTabView()
        .environmentObject(AppSettings.shared)
}
