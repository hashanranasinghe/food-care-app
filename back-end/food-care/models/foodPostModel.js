const mongoose = require("mongoose");

const foodSchema = new mongoose.Schema(
  {
    user_id: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      ref: "User",
    },

    title: { type: String, required: true },
    author: { type: String },
    description: { type: String, required: true },
    quantity: { type: String },
    isComplete: { type: Boolean },
    requests: {
      type: Array,
      default: [],
    },
    acceptRequests: {
      type: [
        {
          userId: { type: String },
          status: { type: String },
        },
      ],
      default: [],
    },
    availableTime: {
      startTime: {
        type: String,
      },
      endTime: {
        type: String,
      },
    },
    category: {
      type: String,
    },
    location: {
      lan: {
        type: String,
      },
      lon: {
        type: String,
      },
    },
    imageUrls: { type: Array },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("FoodPost", foodSchema);
