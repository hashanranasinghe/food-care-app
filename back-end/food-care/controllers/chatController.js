const express = require("express");
const Chat = require("../models/chatModel");
const Conversation = require("../models/conversation");
const asyncHandler = require("express-async-handler");
const admin = require("firebase-admin");
const fcm = require("fcm-node");
const serviceAccount = require("../push-notification-key.json");
const certPath = admin.credential.cert(serviceAccount);
const FCM = new fcm(certPath);
const User = require("../models/userModel");

//add==========================================================================
const createMessage = asyncHandler(async (req, res) => {

  const newMessage = new Chat(req.body);

  const conversation = await Conversation.findById(req.body.conversationId);
  const receiverId = conversation.members.find((id) => id.toString() !== req.body.sender_id);
console.log(receiverId);
  const receiver = await User.findById(receiverId);
  const sender = await User.findById(req.body.sender_id);
  if (!receiver || !sender) {
    throw new Error("Something went to wrong");
  }
console.log(receiver);
  try {
    var message = {
      registration_ids: receiver.deviceToken,

      notification: {
        title: sender.name,
        body: req.body.message,
      },

      data: {
        type: "chat",
        userId: receiverId,
        receiverName:sender.name,
        conversationId:req.body.conversationId,
        receiverId:req.body.sender_id
      },
    };

    FCM.send(message, function (err, response) {
      if (err) {
        res.status(500);
        throw new Error(err);
      } else {
        console.log("notification sent");
        res.status(200).json({
          message: "notification sent",
        });
        newMessage.save();
      }
    });
  } catch (e) {
    throw e;
  }
});

//get==========================================================================
const getMessages = asyncHandler(async (req, res) => {
  console.log("==============================================")
  const getMessageList = await Chat.find({
    conversationId: req.params.conversationId,
  });
  if (!getMessageList) {
    res.status(404);
    throw new Error("Messages not found");
  }
  res.status(200).json(getMessageList);
});

module.exports = { createMessage, getMessages };
