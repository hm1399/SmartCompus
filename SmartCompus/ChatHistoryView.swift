//
//  ChatHistoryView.swift
//  SmartCompus
//
//  Created by Mandy on 2025/9/30.
//

import SwiftUI

struct _ChatHistoryView: View {
    @EnvironmentObject var _app_settings: AppSettings
    @EnvironmentObject var _chat_manager: ChatManager
    @Environment(\.dismiss) private var _dismiss
    
    var body: some View {
        NavigationView {
            List {
                if _chat_manager.conversations.isEmpty {
                    _empty_history_view()
                } else {
                    ForEach(_chat_manager.conversations) { conversation in
                        Button(action: {
                            _chat_manager._select_conversation(conversation)
                            _dismiss()
                        }) {
                            _conversation_row(conversation: conversation)
                        }
                    }
                    .onDelete(perform: _delete_conversations)
                }
            }
            .navigationTitle(_app_settings._text(.chat_history))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(_app_settings._text(.chat_history_close)) {
                        _dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        _chat_manager._create_new_conversation()
                        _dismiss()
                    }) {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
        }
    }
    
    // 对话行
    @ViewBuilder
    private func _conversation_row(conversation: _ChatConversation) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(conversation.title.isEmpty ? _app_settings._text(.chat_untitled) : conversation.title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Spacer()
                
                if _chat_manager.current_conversation?.id == conversation.id {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.blue)
                }
            }
            
            HStack {
                Text(_format_date(conversation.updated_at))
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                
                Text("•")
                    .foregroundColor(.gray)
                
                Text("\(conversation.messages.count) \(_app_settings._text(.chat_messages_count))")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            
            if let last_message = conversation.messages.last {
                Text(last_message.content)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
    }
    
    // 空历史视图
    @ViewBuilder
    private func _empty_history_view() -> some View {
        VStack(spacing: 16) {
            Image(systemName: "clock")
                .font(.system(size: 50))
                .foregroundColor(.gray.opacity(0.5))
            
            Text(_app_settings._text(.chat_no_history))
                .font(.body)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .listRowBackground(Color.clear)
    }
    
    // 删除对话
    private func _delete_conversations(at offsets: IndexSet) {
        for index in offsets {
            let conversation = _chat_manager.conversations[index]
            _chat_manager._delete_conversation(conversation)
        }
    }
    
    // 格式化日期
    private func _format_date(_ date: Date) -> String {
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return _app_settings._text(.chat_today) + " " + formatter.string(from: date)
        } else if calendar.isDateInYesterday(date) {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            return _app_settings._text(.chat_yesterday) + " " + formatter.string(from: date)
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd HH:mm"
            return formatter.string(from: date)
        }
    }
}

#Preview {
    _ChatHistoryView()
        .environmentObject(AppSettings.shared)
        .environmentObject(ChatManager.shared)
}
