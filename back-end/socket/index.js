const io = require("socket.io")(8900, {
  cors: {
    origin: "http://localhost:5000",
  },
});

let users = [];

const addUser = (userId, socketId) => {
  !users.some((user) => user.userId === userId) &&
    users.push({ userId, socketId });
};

io.on("connection", (socket) => {
  //when connect
  console.log("A user connected");
  //take userId and socketId from user
  socket.on("addUser", (userId) => {
    addUser(userId, socket.id);
    io.emit("getUsers", users);
  });

  const removeUser = (socketId) => {
    users = users.filter((user) => user.socketId !== socketId);
  };

  const getUser = (userId) => {
    return users.find((user) => user.userId === userId);
  };

  //send and get message
  socket.on("sendMessage", ({ conversationId,sender_id, receiverId, message,createdAt,updatedAt }) => {
    console.log("Received message from sender " + sender_id + " to receiver " + receiverId + ": " + message+"conversationId"+conversationId);
    const user = getUser(receiverId);
    io.to(user.socketId).emit("getMessage", {
      conversationId,
      sender_id,
      message,
      createdAt,
      updatedAt
    });
  });

  //when disconnect
  socket.on("disconnect", () => {
    console.log("a user disconnected");
    removeUser(socket.id);
    io.emit("getUsers", users);
  });
});
