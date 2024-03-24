import React, { useEffect, useState } from "react";
import Card from "@mui/material/Card";
import CardContent from "@mui/material/CardContent";
import Typography from "@mui/material/Typography";
import { CardActionArea } from "@mui/material";
import card1 from "../assests/data/Dashboard/card1.jpeg";
import card2 from "../assests/data/Dashboard/card2.png";
import card3 from "../assests/data/Dashboard/card3.jpg";
import CountUp from "react-countup";

import { useFetchData } from "../hooks/useFetchData";
const CpostCount = 1000;

export default function MultiActionAreaCard({food,community,users}) {


  const cardData = [
    {
      id: 1,
      title: `User Count = ${users}`,
      description: "",
      imageUrl: card1,
    },
    {
      id: 2,
      title: `Food Posts = ${food}`,
      description: "",
      imageUrl: card2,
    },

    {
      id: 3,
      title: `Community Posts= ${community} `,
      description: "",
      imageUrl: card3,
    },
    {
      id: 4,
      title: `Completed Posts = ${CpostCount}`,
      description: "",
      imageUrl: card3,
    },
  ];

  return (
    <div style={{ display: "flex", gap: "20px" }}>
      {cardData.map((card) => (
        <Card key={card.id} sx={{ maxWidth: 345 }}>
          <CardActionArea>
            <img src={card.imageUrl} alt={card.alt} height="180" />

            <CardContent>
              <Typography gutterBottom variant="h5" component="div">
                {/* Use CountUp component here for the count animation */}
                {card.id === 1 ||
                card.id === 2 ||
                card.id === 3 ||
                card.id === 4 ? (
                  <div
                    style={{
                      display: "flex",
                      flexDirection: "column",
                      alignItems: "center",
                      marginTop: "10px",
                    }}
                  >
                    <Typography variant="h1" style={{ fontSize: "35px" }}>
                      <CountUp
                        start={0}
                        end={parseInt(card.title.split("=")[1].trim())}
                        duration={3}
                        separator=","
                        decimals={0}
                        decimal="."
                      />
                    </Typography>
                    <Typography
                      variant="h6"
                      style={{
                        fontSize: "20px",
                        color: "gray",
                        marginTop: "8px",
                      }}
                    >
                      {card.id === 1
                        ? "User Count"
                        : card.id === 2
                        ? "Food Posts"
                        : card.id === 3
                        ? "Community Posts"
                        : "Completed Posts"}
                    </Typography>
                  </div>
                ) : (
                  <CountUp
                    start={0}
                    end={parseInt(card.title.split("=")[1].trim())}
                    duration={3}
                    separator=","
                    decimals={0}
                    decimal="."
                    prefix={card.title.split("=")[0].trim()}
                  />
                )}
              </Typography>
              <Typography
                variant="body3"
                color="text.secondary"
                className="text-lg text-gray-600"
              >
                {card.description}
              </Typography>
            </CardContent>
          </CardActionArea>
        </Card>
      ))}
    </div>
  );
}
