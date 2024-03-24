import apiEndpoints from "../api/apiEndpoints";

export default function useChatFunction(endPointKey, method) {
    const chatFunction = async (data) => {
      try {
        const accessToken = JSON.parse(localStorage.getItem("user"));
        if (!accessToken) {
          console.log("No token found.");
          return;
        }
  
        const response = await fetch(apiEndpoints[endPointKey], {
          method,
          headers: {
            Authorization: `Bearer ${accessToken}`,
            "Content-Type": "application/json", // Set the content type to JSON
          },
          body: JSON.stringify(data), // Convert the data to JSON and send it in the request body
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
  
    return { chatFunction };
  }
  