import React, { useRef, useEffect } from "react";
import { Sidebar } from "../components";

const Layout = ({ children }) => {
  const divRef = useRef(null);

  useEffect(() => {
    const handleResize = () => {
      if (divRef.current) {
        divRef.current.style.width = `${window.innerWidth}px`;
        // divRef.current.style.height = `${window.innerHeight}px`;
      }
    };

    window.addEventListener("resize", handleResize);
    handleResize();

    return () => {
      window.removeEventListener("resize", handleResize);
    };
  }, []);

  return (
    <>
      <div  className=" flex w-divRef.current.style.width pl-10 pr-10">
        <div className="relative z-10">
          <Sidebar />
        </div>

        <div ref={divRef} className="flex  mt-20">
          {children}
          
        </div>
      </div>
    </>
  );
};

export default Layout;
