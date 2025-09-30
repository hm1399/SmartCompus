//
//  ChatManager.swift
//  SmartCompus
//
//  Created by Mandy on 2025/9/30.
//

import Foundation
import Combine

class ChatManager: ObservableObject {
    @Published var conversations: [_ChatConversation] = []
    @Published var current_conversation: _ChatConversation?
    
    static let shared = ChatManager()
    
    private let _storage_key = "saved_conversations"
    
    private init() {
        _load_conversations()
        if conversations.isEmpty {
            _create_sample_conversations()
        }
    }
    
    // 创建新对话
    func _create_new_conversation() {
        let new_conversation = _ChatConversation(
            title: "新对话",
            messages: []
        )
        conversations.insert(new_conversation, at: 0)
        current_conversation = new_conversation
        _save_conversations()
    }
    
    // 发送消息
    func _send_message(content: String) {
        guard var conversation = current_conversation else { return }
        
        // 添加用户消息
        let user_message = _ChatMessage(sender: .user, content: content)
        conversation.messages.append(user_message)
        conversation.updated_at = Date()
        
        // 如果是第一条消息，用消息内容作为标题
        if conversation.messages.count == 1 {
            conversation.title = String(content.prefix(20))
        }
        
        // 更新当前对话
        _update_conversation(conversation)
        
        // 模拟 AI 回复（延迟 1 秒）
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?._generate_ai_response(for: conversation.id, user_message: content)
        }
    }
    
    // 生成 AI 回复（模拟）
    private func _generate_ai_response(for conversation_id: UUID, user_message: String) {
        guard var conversation = conversations.first(where: { $0.id == conversation_id }) else { return }
        
        let ai_response = _get_ai_response(for: user_message)
        let ai_message = _ChatMessage(sender: .ai, content: ai_response)
        
        conversation.messages.append(ai_message)
        conversation.updated_at = Date()
        
        _update_conversation(conversation)
    }
    
    // 模拟 AI 响应
    private func _get_ai_response(for message: String) -> String {
        let responses = [
            "我明白了，让我帮你解答这个问题。",
            "这是一个很好的问题！根据我的理解...",
            "关于你的问题，我建议...",
            "让我为你查询一下相关信息。",
            "好的，我会尽力帮助你！"
        ]
        return responses.randomElement() ?? "收到你的消息了！"
    }
    
    // 更新对话
    private func _update_conversation(_ conversation: _ChatConversation) {
        if let index = conversations.firstIndex(where: { $0.id == conversation.id }) {
            conversations[index] = conversation
            if current_conversation?.id == conversation.id {
                current_conversation = conversation
            }
            _save_conversations()
        }
    }
    
    // 选择对话
    func _select_conversation(_ conversation: _ChatConversation) {
        current_conversation = conversation
    }
    
    // 删除对话
    func _delete_conversation(_ conversation: _ChatConversation) {
        conversations.removeAll { $0.id == conversation.id }
        if current_conversation?.id == conversation.id {
            current_conversation = nil
        }
        _save_conversations()
    }
    
    // 保存对话
    private func _save_conversations() {
        if let encoded = try? JSONEncoder().encode(conversations) {
            UserDefaults.standard.set(encoded, forKey: _storage_key)
        }
    }
    
    // 加载对话
    private func _load_conversations() {
        if let data = UserDefaults.standard.data(forKey: _storage_key),
           let decoded = try? JSONDecoder().decode([_ChatConversation].self, from: data) {
            conversations = decoded
        }
    }
    
    // 创建示例对话（首次使用）
    private func _create_sample_conversations() {
        let sample1 = _ChatConversation(
            title: "欢迎使用 AI 助手",
            messages: [
                _ChatMessage(sender: .ai, content: "你好！我是你的 AI 助手，有什么可以帮助你的吗？", timestamp: Date().addingTimeInterval(-3600))
            ],
            created_at: Date().addingTimeInterval(-3600),
            updated_at: Date().addingTimeInterval(-3600)
        )
        
        conversations = [sample1]
        current_conversation = sample1
        _save_conversations()
    }
}
