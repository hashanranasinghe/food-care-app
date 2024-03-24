import React, { useEffect,useState } from "react";
import { Layout } from "../components";
import { useCurrentUser } from "../hooks/useCurrentUser";
import { useFetchData } from "../hooks/useFetchData";
import ConversationCard from "../components/chat/ConversationCard";
import ChatView from "../components/chat/ChatView";

const Chat = () => {
  const { error, isLoading, currentUser, fetchCurrentUser } = useCurrentUser();
  const [conId, setConId] = useState(null);
  const {
    error: conError,
    fetchData: fetchCon,
    data: conData,
    isLoading: conLoading,
  } = useFetchData("getAllconversations");

  const _getCurrentUser = async () => {
    await fetchCurrentUser();
    await fetchCon();
  };

  useEffect(() => {
    _getCurrentUser();
  }, []);
  // Function to handle ConversationCard click
  const handleConversationCardClick = (selectedConId) => {
    setConId(selectedConId);
  };
  return (
    <div>
      <Layout>
        <div class="flex text-gray-800 h-[600px]">
          <div class="flex flex-row h-full w-full overflow-x-hidden">
            <div class="flex flex-col py-8 pl-6 pr-2 w-64 bg-white flex-shrink-0">
              <div class="flex flex-col mt-8">
                <div class="flex flex-row items-center justify-between text-xs">
                  <span class="font-bold text-lg">Conversations</span>
                  <span class="flex items-center justify-center bg-gray-300 h-4 w-4 rounded-full">
                    4
                  </span>
                </div>
                <div class="flex flex-col space-y-1 mt-4 -mx-2 overflow-y-auto">
                  {conData.map((con, index) => (
                    <ConversationCard
                      con={con}
                      currentId={currentUser.id}
                      onSelect={() => handleConversationCardClick(con._id)}
                      key={index}
                    /> // Added key prop
                  ))}
                </div>
              </div>
            </div>
            {conId !== null ? (
              <ChatView conId={conId} currentId={currentUser.id} />
            ) : (
              "Select Conversation"
            )}
          </div>
        </div>
      </Layout>
    </div>
  );
};

export default Chat;
