import React from "react";
import { Layout } from "../components";
import User from "../assests/user.png";
import { useNavigate } from "react-router-dom";
import { CircularProgress } from "@mui/material";
import { useFetchData } from "../hooks/useFetchData";
import { useEffect } from "react";
const Users = () => {
  const { error, fetchData, data, isLoading } = useFetchData("allUsers");
  const navigate = useNavigate();

  const _getUsers = async () => {
    await fetchData();
  };
  useEffect(() => {
    _getUsers();
  }, []);
  const handleRowClick = (userId) => {
    navigate(`/UserProfileView/${userId}`);
  };

  if (isLoading) {
    return (
      <Layout>
        <div className="flex flex-col items-center w-full justify-center">
          <CircularProgress />
        </div>
      </Layout>
    );
  }

  if (error) {
    return (
      <Layout>
        <div className="flex flex-col items-center w-full justify-center">
          <p>{error}</p>
        </div>
      </Layout>
    );
  }

  return (
    <Layout>
      <div className="relative w-full flex flex-col shadow-lg mb-6 mt-12">
        <div className="p-4 ">
          <table class="w-full min-w-max table-auto text-left">
            <thead>
              <tr>
                <th className="border-b-2 border-gray-200 bg-gray-100 p-4">
                  profile picture
                </th>
                <th className="border-b-2 border-gray-200 bg-gray-100 p-4">
                  Name
                </th>

                <th className="border-b-2 border-gray-200 bg-gray-100 p-4">
                  Email
                </th>

                <th className="border-b-2 border-gray-200 bg-gray-100 p-4">
                  Phone Number
                </th>

                <th className="border-b-2 border-gray-200 bg-gray-100 p-4">
                  Verify
                </th>
              </tr>
            </thead>
            <tbody>
              {data?.map((user) => (
                <tr
                  key={user._id}
                  onClick={() => handleRowClick(user._id)}
                  className="cursor-pointer"
                >
                  <td className="p-4 border-b border-gray-500 items-center">
                    {/* Add profile picture here */}
                    {user.imageUrl ? (
                      <img
                        src={user.imageUrl}
                        alt={`${user.name}'s Profile`}
                        className="h-10 w-10 rounded-full object-cover"
                      />
                    ) : (
                      <img
                        src={User} // Replace this with the correct path to user.png
                        alt={`${user.name}'s Profile`}
                        className="h-10 w-10 rounded-full object-cover"
                      />
                    )}
                  </td>
                  <td class="p-4 border-b border-gray-500 ...">{user.name}</td>

                  <td class="p-4 border-b border-gray-500 ...">{user.email}</td>
                  <td class="p-4 border-b border-gray-500 ...">{user.phone}</td>
                  <td class="p-4 border-b border-gray-500 ...">
                    {user.isVerify ? "Yes" : "No"}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </Layout>
  );
};

export default Users;
