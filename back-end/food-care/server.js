const express = require("express");
const connectDb = require("./config/dbConnection");
const errorHandler = require("./middleware/errorHandler");
const dotenv = require("dotenv").config();
const http = require("http");
const app = express();
const server = http.createServer(app);
const port = process.env.PORT || 5000;

connectDb();
app.use(express.json());
app.set("view engine", "ejs");
app.use("/api/report",require("./routes/reportRoute"));
app.use("/api/forums", require("./routes/forumRoutes"));
app.use("/api/users", require("./routes/userRoutes"));
app.use("/api/food", require("./routes/foodPostRoute"));
app.use("/api/conversation", require("./routes/conversationRoute"));
app.use("/api/message", require("./routes/chatRoute"));

app.use("/uploads", express.static("uploads"));
app.use("/foodimages", express.static("foodimages"));
app.use("/profiles", express.static("profiles"));

/*app.use("/api/notification",require("./routes/notificationRoute"));*/

app.use(errorHandler);

server.listen(port, () => {
  console.log("Server is running on port " + port);
});
