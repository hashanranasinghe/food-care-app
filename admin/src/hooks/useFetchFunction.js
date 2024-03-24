import apiEndpoints from "../api/apiEndpoints";

export default function useFetchFunction(endPointKey, params, method) {
  const fetchFunction = async () => {
    try {
      const accessToken = JSON.parse(localStorage.getItem("user"));
      if (!accessToken) {
        console.log("No token found.");
        return;
      }

      const response = await fetch(apiEndpoints[endPointKey], {
        method: method,
        headers: {
          Authorization: `Bearer ${accessToken}`,
        },
      });

      if (response.ok) {
        const jsonResponse = await response.json();
        console.log(jsonResponse);
        console.log("Request successful.");
      } else {
        console.log("Failed to perform the request.");
      }
    } catch (error) {
      console.error("An error occurred:", error);
    }
  };

  return { fetchFunction };
}
