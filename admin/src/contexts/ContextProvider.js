import React, {createContext,useContext,useState} from 'react';

const StateContext= createContext();

const initialState={
    chat: false,
    userprofile: false,
    Notification: false,
}

export const ContextProvider =({ children}) =>{
   const [activeMenu, setActiveMenu] = useState(true);

   const [isClicked, setisClicked] = useState(initialState)

const [screenSize, setscreenSize] = useState(undefined)

const handleClick = (clicked) => {
    setisClicked({...initialState,[clicked]:true});
}
    return (
        <StateContext.Provider 
        value = {{
            activeMenu,
            setActiveMenu,
            isClicked,
            setisClicked,
            handleClick,
            screenSize,
            setscreenSize,
        }} >

            {children}

        </StateContext.Provider>


    )
}

export const useStateContext =()=>useContext
(StateContext)