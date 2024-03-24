import { useState } from "react";
import apiEndpoints from "../api/apiEndpoints";

export const useFetchData = (endPointKey) => {
  const [error, setError] = useState(null);
  const [isLoading, setIsLoading] = useState(null);
  const [data, setData] = useState([]);
  const fetchData = async () => {
    setIsLoading(true);
    const accessToken = JSON.parse(localStorage.getItem("user"));
    if (!accessToken) {
      console.log("No token found.");
      return;
    }

    try {
  
      const response = await fetch(apiEndpoints[endPointKey], {
        headers: {
          Authorization: `Bearer ${accessToken}`,
        },
      });
      const json = await response.json(); 
      setData(json);
      setIsLoading(false);
    } catch (error) {
      console.log(error);
      setError(error);
      setIsLoading(false);
    }
  };

  return { error, isLoading, data, fetchData };
};

