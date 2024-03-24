const mongoose = require("mongoose");

const reportSchema = new mongoose.Schema(
  {
    user_id: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      ref: "User",
    },
    post: {
      id: {
        type: String,
      },
      type: {
        type: String,
      },
    },
    description: {
      type: String,
    },
    action: {
      type: String,
    },
  },
  {
    timestamps: true,
  }
);
module.exports = mongoose.model("Report", reportSchema);
