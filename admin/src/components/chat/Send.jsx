import React from "react";

function Send({text}) {
  return (
    <div class="col-start-6 col-end-13 p-3 rounded-lg">
      <div class="flex items-center justify-start flex-row-reverse">
        <div class="flex items-center justify-center h-10 w-10 rounded-full bg-indigo-500 flex-shrink-0">
          A
        </div>
        <div class="relative mr-3 text-sm bg-indigo-100 py-2 px-4 shadow rounded-xl">
          <div>{text}</div>
        </div>
      </div>
    </div>
  );
}

export default Send;
