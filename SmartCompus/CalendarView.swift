//
//  CalendarView.swift
//  SmartCompus
//
//  Created by Mandy on 2025/9/30.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var _app_settings: AppSettings
    
    var body: some View {
        NavigationView {
            VStack {
                Text(_app_settings._text(.calendar_title))
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .navigationTitle(_app_settings._text(.calendar_title))
        }
    }
}

#Preview {
    CalendarView()
        .environmentObject(AppSettings.shared)
}
