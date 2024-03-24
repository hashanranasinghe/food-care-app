import React, { useEffect } from "react";
import { useFetchIdData } from "../../hooks/useFetchIdData";

function ConversationCard({ con, currentId, onSelect }) {
  const id = con.members.find((m) => m !== currentId);

  const { error, fetchData, data, isLoading } = useFetchIdData("user", id);
  const _getUser = async () => {
    await fetchData();
  };

  useEffect(() => {
    _getUser();
  }, []);

  return (
    <>
      <button
        class="flex flex-row items-center hover:bg-gray-100 rounded-xl p-2"
        onClick={onSelect}
      >
        {data?.imageUrl ? (
          <img
            src={data?.imageUrl}
            alt={`${data?.name}'s Profile`}
            className="h-10 w-10 rounded-full object-cover"
          />
        ) : (
          <div class="flex items-center justify-center h-8 w-8 bg-indigo-200 rounded-full">
            {data?.name[1]}
          </div>
        )}
        <div class="ml-2 text-sm font-semibold">{data?.name}</div>
      </button>
    </>
  );
}

export default ConversationCard;
