const mongoose = require("mongoose");

const chatSchema = new mongoose.Schema(
  {
    conversationId:{
      type:String,
    },
    sender_id: {
      type:String,
      required: true,
    },
    message: {
      type: String,
      required: true,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("Chat", chatSchema);
