import React from "react";
import profilePic from "../assests/data/avatar.jpg"; // Corrected the import path

const AdminCard = ({ admins }) => {
  return (
    <>
      {admins.map((admin, index) => (
        <div
          key={index}
          className="bg-white ml-4 rounded-md p-4 flex flex-col items-center border border-gray-400 shadow-lg mb-4"
        >
          <div className="mt-5">
            <img src={profilePic} alt="Avatar" className="h-22 rounded-full" />
          </div>
          <div className="ml-3 mt-10">
            <div className="mb-3">
              <span className="font-semibold">Name:</span> {admin.name}
            </div>
            <div className="mb-3">
              <span className="font-semibold">Email:</span> {admin.email}
            </div>
            <div className="mb-3">
              <span className="font-semibold">Phone Number:</span>{" "}
              {admin.phoneNumber}
            </div>
            <div>
              <span className="font-semibold">Address:</span> {admin.address}
            </div>
          </div>
        </div>
      ))}
    </>
  );
};

export default AdminCard;
