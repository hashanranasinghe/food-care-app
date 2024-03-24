const apiEndpoints = {
  currentUser: "/api/users/current",
  forums: "/api/forums",
  reports: "/api/report",
  //chat
  getAllconversations: "/api/conversation/chats",
  getMesages:(conId)=>`/api/message/${conId}`,
  sendMesages:"/api/message/",
  updateReport: (reportId) => `api/report/adminreport/${reportId}`,
  deleteForums: (forumId) => `api/forums/ownforums/${forumId}`,
  deleteFoods: (foodId) => `api/food/adminfood/${foodId}`,
  foods: "/api/food",
  getfoodpost: (foodId) => `/api/food/${foodId}`,
  getforumpost: (forumId) => `/api/forums/${forumId}`,
  user: (userId) => `/api/users/user/${userId}`,
  allUsers: "/api/users/users",
};

export default apiEndpoints;
