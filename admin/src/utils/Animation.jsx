import React from "react";
import { useLottie } from "lottie-react";
import  NoData  from "../assests/json/NoData.json";

function AnimationNoData() {
  const options = {
    animationData: NoData,
    loop: true,
  };

  const { View } = useLottie(options);
  return <>{View}</>;
}

export default AnimationNoData;
