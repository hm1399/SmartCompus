//
//  HomeView.swift
//  SmartCompus
//
//  Created by Mandy on 2025/9/30.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var _app_settings: AppSettings
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // 顶部问候语和通知
                    _header_view()
                    
                    // 天气卡片
                    _weather_card()
                    
                    // 今日课程
                    _today_schedule_card()
                    
                    // 快速操作
                    _quick_actions_card()
                    
                    // 校园资讯
                    _campus_news_card()
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - 顶部视图
    @ViewBuilder
    private func _header_view() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(_app_settings._text(.greeting_title))
                    .font(.system(size: 24, weight: .bold))
                Text(_app_settings._text(.greeting_subtitle))
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            ZStack(alignment: .topTrailing) {
                Image(systemName: "bell.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.primary)
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 8, height: 8)
                    .offset(x: 2, y: -2)
            }
        }
        .padding(.horizontal, 4)
    }
    
    // MARK: - 天气卡片
    @ViewBuilder
    private func _weather_card() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top, spacing: 4) {
                    Image(systemName: "sun.max.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.primary)
                    Text("22°C")
                        .font(.system(size: 28, weight: .semibold))
                }
                Text(_app_settings._text(.weather_description))
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 8) {
                Text(_app_settings._text(.weather_date))
                    .font(.system(size: 16, weight: .medium))
                Text(_app_settings._text(.weather_weekday))
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
        }
        .padding(20)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
    }
    
    // MARK: - 今日课程卡片
    @ViewBuilder
    private func _today_schedule_card() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 8) {
                Image(systemName: "clock.fill")
                    .foregroundColor(Color(red: 0.4, green: 0.3, blue: 0.9))
                Text(_app_settings._text(.today_schedule_title))
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
            }
            
            _schedule_item(time: "09:00", title: _app_settings._text(.course_one_title), location: "AC1 LT-6", status: _app_settings._text(.course_status), statusColor: Color(red: 0.4, green: 0.3, blue: 0.9))
            
            Divider()
                .padding(.leading, 60)
            
            _schedule_item(time: "14:00", title: _app_settings._text(.course_two_title), location: "Y5-201", status: _app_settings._text(.course_status), statusColor: Color.green)
            
            Divider()
                .padding(.leading, 60)
            
            _schedule_item(time: "16:00", title: _app_settings._text(.course_three_title), location: "AC3-G12", status: _app_settings._text(.course_status), statusColor: Color(red: 0.4, green: 0.3, blue: 0.9))
        }
        .padding(20)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
    }
    
    @ViewBuilder
    private func _schedule_item(time: String, title: String, location: String, status: String, statusColor: Color) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Text(time)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .frame(width: 40, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                HStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Text(location)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Text(status)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(statusColor)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(statusColor.opacity(0.1))
                .cornerRadius(8)
        }
    }
    
    // MARK: - 快速操作卡片
    @ViewBuilder
    private func _quick_actions_card() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(_app_settings._text(.quick_actions_title))
                .font(.system(size: 16, weight: .semibold))
                .padding(.horizontal, 4)
            
            HStack(spacing: 0) {
                _quick_action_button(icon: "calendar", iconColor: Color(red: 0.4, green: 0.3, blue: 0.9), title: _app_settings._text(.quick_action_schedule))
                Spacer()
                _quick_action_button(icon: "chart.bar.fill", iconColor: Color(red: 0.4, green: 0.3, blue: 0.9), title: _app_settings._text(.quick_action_credits))
                Spacer()
                _quick_action_button(icon: "book.fill", iconColor: Color.green, title: _app_settings._text(.quick_action_library))
                Spacer()
                _quick_action_button(icon: "mappin.and.ellipse", iconColor: Color.red, title: _app_settings._text(.quick_action_map))
                Spacer()
                _quick_action_button(icon: "cup.and.saucer.fill", iconColor: Color.orange, title: _app_settings._text(.quick_action_dining))
            }
        }
        .padding(20)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
    }
    
    @ViewBuilder
    private func _quick_action_button(icon: String, iconColor: Color, title: String) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(iconColor)
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(.primary)
        }
        .frame(width: 60)
    }
    
    // MARK: - 校园资讯卡片
    @ViewBuilder
    private func _campus_news_card() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 8) {
                Image(systemName: "person.2.fill")
                    .foregroundColor(Color(red: 0.4, green: 0.3, blue: 0.9))
                Text(_app_settings._text(.campus_news_title))
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
            }
            
            _news_item(
                image: "photo1",
                title: _app_settings._text(.news_one_title),
                description: _app_settings._text(.news_one_description),
                time: _app_settings._text(.news_one_time)
            )
            
            Divider()
            
            _news_item(
                image: "photo2",
                title: _app_settings._text(.news_two_title),
                description: _app_settings._text(.news_two_description),
                time: _app_settings._text(.news_two_time)
            )
        }
        .padding(20)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
        .padding(.bottom, 20)
    }
    
    @ViewBuilder
    private func _news_item(image: String, title: String, description: String, time: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .lineLimit(1)
                Text(description)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .lineLimit(2)
                Text(time)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
    }
}

#Preview {
    HomeView()
}
