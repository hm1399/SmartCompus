//
//  AIAssistantView.swift
//  SmartCompus
//
//  Created by Mandy on 2025/9/30.
//

import SwiftUI

struct AIAssistantView: View {
    @EnvironmentObject var _app_settings: AppSettings
    @StateObject private var _chat_manager = ChatManager.shared
    @State private var _show_history = false
    @State private var _message_input = ""
    @Binding var _is_presented: Bool
    @Environment(\.dismiss) private var _dismiss
    
    init(isPresented: Binding<Bool> = .constant(true)) {
        self.__is_presented = isPresented
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // 自定义导航栏
            _custom_navigation_bar()
            
            // 聊天消息列表
            _chat_messages_view()
            
            // 输入框
            _message_input_bar()
        }
        .background(Color(UIColor.systemGroupedBackground))
        .sheet(isPresented: $_show_history) {
            _ChatHistoryView()
                .environmentObject(_app_settings)
                .environmentObject(_chat_manager)
        }
        .onAppear {
            if _chat_manager.current_conversation == nil {
                _chat_manager._create_new_conversation()
            }
        }
    }
    
    // 自定义导航栏
    @ViewBuilder
    private func _custom_navigation_bar() -> some View {
        HStack(spacing: 12) {
            // 返回按钮
            Button(action: {
                withAnimation {
                    _is_presented = false
                }
            }) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                    Text(_app_settings._text(.chat_back))
                        .font(.system(size: 17))
                }
                .foregroundColor(.blue)
            }
            
            Spacer()
            
            // 标题
            Text(_app_settings._text(.service_title))
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.primary)
            
            Spacer()
            
            // 菜单按钮
            Menu {
                Button(action: {
                    _show_history = true
                }) {
                    Label(_app_settings._text(.chat_history), systemImage: "clock")
                }
                
                Button(action: {
                    _chat_manager._create_new_conversation()
                }) {
                    Label(_app_settings._text(.new_chat), systemImage: "square.and.pencil")
                }
            } label: {
                Image(systemName: "ellipsis.circle")
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(UIColor.systemBackground))
        .overlay(
            Divider()
                .frame(maxWidth: .infinity, maxHeight: 0.5)
                .background(Color.gray.opacity(0.3)),
            alignment: .bottom
        )
    }
    
    // 聊天消息视图
    @ViewBuilder
    private func _chat_messages_view() -> some View {
        ScrollViewReader { proxy in
            ScrollView {
                if let conversation = _chat_manager.current_conversation {
                    if conversation.messages.isEmpty {
                        _empty_state_view()
                    } else {
                        LazyVStack(spacing: 16) {
                            ForEach(conversation.messages) { message in
                                _message_bubble(message: message)
                                    .id(message.id)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .onChange(of: conversation.messages.count) {
                            if let last_message = conversation.messages.last {
                                withAnimation {
                                    proxy.scrollTo(last_message.id, anchor: .bottom)
                                }
                            }
                        }
                    }
                } else {
                    _empty_state_view()
                }
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
    }
    
    // 空状态视图
    @ViewBuilder
    private func _empty_state_view() -> some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "sparkles")
                .font(.system(size: 60))
                .foregroundColor(.blue.opacity(0.6))
            
            Text(_app_settings._text(.chat_welcome))
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(_app_settings._text(.chat_welcome_subtitle))
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // 消息气泡
    @ViewBuilder
    private func _message_bubble(message: _ChatMessage) -> some View {
        HStack(alignment: .top, spacing: 12) {
            if message.sender == .user {
                Spacer()
            }
            
            // 头像
            if message.sender == .ai {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 36, height: 36)
                    .overlay(
                        Image(systemName: "sparkles")
                            .font(.system(size: 16))
                            .foregroundColor(.blue)
                    )
            }
            
            // 消息内容
            VStack(alignment: message.sender == .user ? .trailing : .leading, spacing: 4) {
                Text(message.content)
                    .font(.system(size: 16))
                    .foregroundColor(message.sender == .user ? .white : .primary)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(message.sender == .user ? Color.blue : Color(UIColor.secondarySystemGroupedBackground))
                    )
                
                Text(_format_time(message.timestamp))
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 4)
            }
            .frame(maxWidth: 280, alignment: message.sender == .user ? .trailing : .leading)
            
            // 用户头像
            if message.sender == .user {
                Circle()
                    .fill(Color.purple.opacity(0.1))
                    .frame(width: 36, height: 36)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.purple)
                    )
            }
            
            if message.sender == .ai {
                Spacer()
            }
        }
    }
    
    // 消息输入栏
    @ViewBuilder
    private func _message_input_bar() -> some View {
        VStack(spacing: 0) {
            // 顶部分隔线
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 0.5)
            
            // 输入区域
            HStack(alignment: .bottom, spacing: 12) {
                // 附加功能按钮（占位）
                Button(action: {}) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.gray.opacity(0.6))
                }
                .opacity(0.7)
                
                // 输入框容器
                HStack(spacing: 8) {
                    TextField(_app_settings._text(.chat_input_placeholder), text: $_message_input, axis: .vertical)
                        .textFieldStyle(.plain)
                        .font(.system(size: 16))
                        .lineLimit(1...5)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .frame(minHeight: 38)
                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(UIColor.secondarySystemGroupedBackground))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.15), lineWidth: 0.5)
                )
                
                // 发送按钮
                Button(action: _send_message) {
                    ZStack {
                        Circle()
                            .fill(_message_input.isEmpty ? Color.gray.opacity(0.3) : Color.blue)
                            .frame(width: 36, height: 36)
                        
                        Image(systemName: "arrow.up")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
                .disabled(_message_input.isEmpty)
                .animation(.easeInOut(duration: 0.2), value: _message_input.isEmpty)
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            .padding(.bottom, 12)
            .background(
                Color(UIColor.systemBackground)
                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: -2)
            )
        }
    }
    
    // 发送消息
    private func _send_message() {
        let message = _message_input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !message.isEmpty else { return }
        
        _chat_manager._send_message(content: message)
        _message_input = ""
    }
    
    // 格式化时间
    private func _format_time(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

#Preview {
    AIAssistantView()
        .environmentObject(AppSettings.shared)
}
