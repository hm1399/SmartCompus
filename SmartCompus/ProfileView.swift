//
//  ProfileView.swift
//  SmartCompus
//
//  Created by Mandy on 2025/9/30.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var _app_settings: AppSettings
    @State private var _show_language_picker = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    _user_profile_card()
                    _academic_info_card()
                    _contact_section()
                    _settings_menu()
                    _app_settings_section()
                    _logout_button()
                    _version_info()
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
                .padding(.bottom, 20)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle(_app_settings._text(.profile_title))
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    @ViewBuilder
    private func _user_profile_card() -> some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color(red: 0.85, green: 0.9, blue: 1.0))
                    .frame(width: 60, height: 60)
                Text("Alex")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(red: 0.4, green: 0.3, blue: 0.9))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Alex Wong")
                    .font(.system(size: 18, weight: .semibold))
                Text("2021001234")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                HStack(spacing: 12) {
                    Text(_app_settings._text(.year_value))
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    Text("CS21-1")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Button(action: {}) {
                Text(_app_settings._text(.edit_button))
                    .font(.system(size: 14))
                    .foregroundColor(.primary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(UIColor.tertiarySystemGroupedBackground))
                    .cornerRadius(8)
            }
        }
        .padding(16)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }
    
    @ViewBuilder
    private func _academic_info_card() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 8) {
                Image(systemName: "graduationcap.fill")
                    .foregroundColor(Color(red: 0.6, green: 0.4, blue: 0.9))
                Text(_app_settings._text(.academic_info_title))
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
            }
            
            VStack(spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(_app_settings._text(.major_label))
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                        Text(_app_settings._text(.major_value))
                            .font(.system(size: 15, weight: .medium))
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 4) {
                        Text(_app_settings._text(.year_label))
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                        Text(_app_settings._text(.year_value))
                            .font(.system(size: 15, weight: .medium))
                    }
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(_app_settings._text(.class_label))
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                        Text("CS21-1")
                            .font(.system(size: 15, weight: .medium))
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 4) {
                        Text(_app_settings._text(.admission_year_label))
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                        Text("2021")
                            .font(.system(size: 15, weight: .medium))
                    }
                }
            }
        }
        .padding(16)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }
    
    @ViewBuilder
    private func _contact_section() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(_app_settings._text(.contact_info_title))
                .font(.system(size: 16, weight: .semibold))
                .padding(.horizontal, 4)
                .padding(.bottom, 4)
            
            VStack(spacing: 0) {
                _contact_item(title: _app_settings._text(.email_label), value: "alexwong@my.cityu.edu.hk")
                
                Divider()
                    .padding(.leading, 16)
                
                _contact_item(title: _app_settings._text(.phone_label), value: "138****5678")
            }
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(12)
        }
    }
    
    @ViewBuilder
    private func _contact_item(title: String, value: String) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                Text(value)
                    .font(.system(size: 15))
            }
            Spacer()
            Button(action: {}) {
                Text(_app_settings._text(.modify_button))
                    .font(.system(size: 14))
                    .foregroundColor(.primary)
            }
        }
        .padding(16)
    }
    
    @ViewBuilder
    private func _settings_menu() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(.gray)
                Text(_app_settings._text(.settings_title))
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
            }
            .padding(.horizontal, 4)
            .padding(.bottom, 4)
            
            VStack(spacing: 0) {
                _settings_menu_item(
                    icon: "person.crop.square.fill",
                    iconColor: Color(red: 0.4, green: 0.3, blue: 0.9),
                    title: _app_settings._text(.settings_personal_info),
                    showBadge: false
                )
                Divider().padding(.leading, 60)
                _settings_menu_item(
                    icon: "creditcard.fill",
                    iconColor: Color.green,
                    title: _app_settings._text(.settings_campus_card),
                    showBadge: true,
                    badgeText: _app_settings._text(.settings_campus_card_balance)
                )
                Divider().padding(.leading, 60)
                _settings_menu_item(
                    icon: "bell.fill",
                    iconColor: Color.orange,
                    title: _app_settings._text(.settings_notifications),
                    showBadge: false
                )
                Divider().padding(.leading, 60)
                _settings_menu_item(
                    icon: "laptopcomputer",
                    iconColor: Color.purple,
                    title: _app_settings._text(.settings_device_management),
                    showBadge: false
                )
                Divider().padding(.leading, 60)
                _settings_menu_item(
                    icon: "shield.fill",
                    iconColor: Color.red,
                    title: _app_settings._text(.settings_privacy_security),
                    showBadge: false
                )
                Divider().padding(.leading, 60)
                _settings_menu_item(
                    icon: "questionmark.circle.fill",
                    iconColor: Color.gray,
                    title: _app_settings._text(.settings_help_center),
                    showBadge: false
                )
            }
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(12)
        }
    }
    
    @ViewBuilder
    private func _settings_menu_item(icon: String, iconColor: Color, title: String, showBadge: Bool, badgeText: String = "") -> some View {
        Button(action: {}) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(iconColor)
                    .frame(width: 28)
                Text(title)
                    .font(.system(size: 15))
                    .foregroundColor(.primary)
                Spacer()
                if showBadge {
                    Text(badgeText)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .padding(16)
        }
    }
    
    @ViewBuilder
    private func _app_settings_section() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(_app_settings._text(.app_settings_title))
                .font(.system(size: 16, weight: .semibold))
                .padding(.horizontal, 4)
                .padding(.bottom, 4)
            
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "moon.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                        .frame(width: 28)
                    Text(_app_settings._text(.dark_mode))
                        .font(.system(size: 15))
                    Spacer()
                    Toggle("", isOn: $_app_settings._is_dark_mode)
                        .labelsHidden()
                }
                .padding(16)
                
                Divider().padding(.leading, 60)
                
                HStack {
                    Image(systemName: "bell.badge.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.orange)
                        .frame(width: 28)
                    Text(_app_settings._text(.push_notifications))
                        .font(.system(size: 15))
                    Spacer()
                    Toggle("", isOn: $_app_settings._is_push_notification_enabled)
                        .labelsHidden()
                }
                .padding(16)
                
                Divider().padding(.leading, 60)
                
                Button(action: {
                    _show_language_picker = true
                }) {
                    HStack {
                        Image(systemName: "globe")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                            .frame(width: 28)
                        Text(_app_settings._text(.language_title))
                            .font(.system(size: 15))
                            .foregroundColor(.primary)
                        Spacer()
                        Text(_app_settings._app_language._display_name)
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding(16)
                }
            }
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(12)
        }
        .sheet(isPresented: $_show_language_picker) {
            _language_picker_sheet()
        }
    }
    
    @ViewBuilder
    private func _logout_button() -> some View {
        Button(action: {}) {
            HStack {
                Spacer()
                HStack(spacing: 8) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.system(size: 16))
                    Text(_app_settings._text(.logout_button))
                        .font(.system(size: 16, weight: .medium))
                }
                Spacer()
            }
            .foregroundColor(.red)
            .padding(16)
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(12)
        }
        .padding(.top, 8)
    }
    
    @ViewBuilder
    private func _version_info() -> some View {
        Text("Smart Campus v2.1.0")
            .font(.system(size: 13))
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity)
            .padding(.top, 8)
            .padding(.bottom, 20)
    }
    
    @ViewBuilder
    private func _language_picker_sheet() -> some View {
        NavigationView {
            List {
                ForEach(AppLanguage.allCases, id: \.rawValue) { language in
                    Button(action: {
                        _app_settings._app_language = language
                        _show_language_picker = false
                    }) {
                        HStack {
                            Text(language._display_name)
                                .font(.system(size: 16))
                                .foregroundColor(.primary)
                            Spacer()
                            if _app_settings._app_language == language {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .navigationTitle(_app_settings._text(.language_sheet_title))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        _show_language_picker = false
                    }) {
                        Text(_app_settings._text(.language_sheet_done))
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppSettings.shared)
}
