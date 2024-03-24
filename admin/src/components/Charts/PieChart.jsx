import React from "react";
import { Chart } from "react-google-charts";

export const data = [
  ["Task", "Hours per Day"],
  ["Work", 11],
  ["Eat", 2],
  ["Commute", 2],
  ["Watch TV", 2],
  ["Sleep", 7],
];

export const options = {
  title: "Mobile App Usages",
};

export function PieChart({food,community,users}) {
  const data = [["Name", "Count"],["Food Posts",food],["Community Posts",community],["Users",users]]
  return (
    <div className=" mx-auto">
    <Chart
      chartType="PieChart"
      data={data}
      options={options}
      width={"100%"}
      height={"600px"}
    />
    </div>
  );
}
export default PieChart