//
//  MessageView.swift
//  SmartCompus
//
//  Created by Mandy on 2025/9/30.
//

import SwiftUI

struct MessageView: View {
    @State private var _unread_count = 2
    @EnvironmentObject var _app_settings: AppSettings
    
    var body: some View {
        NavigationView {
            VStack {
                Text(_app_settings._text(.message_title))
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .navigationTitle(_app_settings._text(.message_title))
        }
    }
}

#Preview {
    MessageView()
        .environmentObject(AppSettings.shared)
}
