package com.board.dto;

public class NotificationDTO {
    private int id;
    private String receiverId;
    private String senderId;
    private int boardId;
    private String message;
    private String isRead;
    private String createdAt;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getReceiverId() { return receiverId; }
    public void setReceiverId(String receiverId) { this.receiverId = receiverId; }

    public String getSenderId() { return senderId; }
    public void setSenderId(String senderId) { this.senderId = senderId; }

    public int getBoardId() { return boardId; }
    public void setBoardId(int boardId) { this.boardId = boardId; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getIsRead() { return isRead; }
    public void setIsRead(String isRead) { this.isRead = isRead; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}