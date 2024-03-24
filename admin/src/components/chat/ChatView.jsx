import React, { useEffect, useState } from "react";
import Reciever from "./Reciever";
import Send from "./Send";
import { useFetchIdData } from "../../hooks/useFetchIdData";
import { CircularProgress } from "@mui/material";
import useChatFunction from "../../hooks/useChatFunction";
import { io } from "socket.io-client";

function ChatView({ conId, currentId }) {
  const [inputData, setInputData] = useState(""); // State to store input data

  const { error, fetchData, data, isLoading } = useFetchIdData(
    "getMesages",
    conId
  );
  const _getMessage = async () => {
    await fetchData();
  };
  const { chatFunction } = useChatFunction("sendMesages", "POST");

  useEffect(() => {
    _getMessage();
  }, []);



  const handleInputChange = (e) => {
    setInputData(e.target.value); // Update input data when the input field changes
  };

  const handleSendClick = async () => {
    // Function to handle sending data to the console
    console.log("Input Data:", inputData);
    // You can also send this data to your backend or perform other actions here

    // Function to handle sending data to the backend
    try {
      const messageData = {
        message: inputData, // The message text
        sender_id: currentId, // The sender's ID
        conversationId: conId, // The conversation ID
      };

      await chatFunction(messageData);
      setInputData(""); // Clear the input field after sending
    } catch (error) {
      console.error("Failed to send message:", error);
    }
  };

  if (isLoading) {
    return (
      <div className="flex flex-col items-center w-full justify-center">
        <CircularProgress />
      </div>
    );
  }

  if (error) {
    return <div>Error: {error.message}</div>;
  }

  if (data !== undefined) {
    return (
      <div className="flex flex-col flex-auto h-full p-6">
        <div className="flex flex-col flex-auto flex-shrink-0 rounded-2xl bg-gray-100 h-full p-4">
          <div className="flex flex-col h-full overflow-x-auto mb-4">
            <div className="flex flex-col h-full">
              <div className="grid grid-cols-12 gap-y-2">
                {data.map((msg, index) => (
                  <>
                    {msg.sender_id === currentId ? (
                      <Send key={index} text={msg.message} />
                    ) : (
                      <Reciever key={index} text={msg.message} />
                    )}
                  </>
                ))}
              </div>
            </div>
          </div>
          <div className="flex flex-row items-center h-16 rounded-xl bg-white w-full px-4">
            <div></div>
            <div className="flex-grow ml-4">
              <div className="relative w-full">
                <input
                  type="text"
                  className="flex w-full border rounded-xl focus:outline-none focus:border-indigo-300 pl-4 h-10"
                  value={inputData}
                  onChange={handleInputChange} // Update input data on change
                />
              </div>
            </div>
            <div className="ml-4">
              <button
                className="flex items-center justify-center bg-indigo-500 hover:bg-indigo-600 rounded-xl text-white px-4 py-1 flex-shrink-0"
                onClick={handleSendClick} // Handle sending data on button click
              >
                <span>Send</span>
                <span className="ml-2">
                  <svg
                    className="w-4 h-4 transform rotate-45 -mt-px"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth="2"
                      d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"
                    ></path>
                  </svg>
                </span>
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default ChatView;
