import { useState } from "react";

export const useCurrentUser = () => {
  const [error, setError] = useState(null);
  const [isLoading, setIsLoading] = useState(null);
  const [currentUser, setCurrentUser] = useState([]);

  const fetchCurrentUser = async () => {
    setIsLoading(true);
    const accessToken = JSON.parse(localStorage.getItem("user"));
    if (!accessToken) {
      console.log("No token found.");
      return;
    }

    try {
      const response = await fetch("/api/users/current", {
        headers: {
          Authorization: `Bearer ${accessToken}`,
        },
      });
      const json = await response.json(); // Await the parsing of the JSON
      setCurrentUser(json);
      setIsLoading(false);
    } catch (error) {
      setError(error);
      setIsLoading(false);
    }
  };

  return { error, isLoading, currentUser, fetchCurrentUser };
};
