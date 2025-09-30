//
//  SmartCompusApp.swift
//  SmartCompus
//
//  Created by Mandy on 2025/9/30.
//

import SwiftUI

@main
struct SmartCompusApp: App {
    @StateObject private var _app_settings = AppSettings.shared
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(_app_settings)
                .preferredColorScheme(_app_settings._color_scheme)
        }
    }
}
