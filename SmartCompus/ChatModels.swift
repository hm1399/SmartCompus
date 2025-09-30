//
//  ChatModels.swift
//  SmartCompus
//
//  Created by Mandy on 2025/9/30.
//

import Foundation

// 消息发送者类型
enum _MessageSender {
    case user
    case ai
}

// 单条聊天消息
struct _ChatMessage: Identifiable, Codable {
    let id: UUID
    let sender: _SenderType
    let content: String
    let timestamp: Date
    
    init(id: UUID = UUID(), sender: _SenderType, content: String, timestamp: Date = Date()) {
        self.id = id
        self.sender = sender
        self.content = content
        self.timestamp = timestamp
    }
    
    enum _SenderType: String, Codable {
        case user
        case ai
    }
}

// 对话会话
struct _ChatConversation: Identifiable, Codable {
    let id: UUID
    var title: String
    var messages: [_ChatMessage]
    let created_at: Date
    var updated_at: Date
    
    init(id: UUID = UUID(), title: String = "", messages: [_ChatMessage] = [], created_at: Date = Date(), updated_at: Date = Date()) {
        self.id = id
        self.title = title
        self.messages = messages
        self.created_at = created_at
        self.updated_at = updated_at
    }
}
