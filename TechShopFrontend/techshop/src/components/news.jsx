import React, { useState, useEffect } from "react";

function News(props) {
  const [count, setCount] = useState(0);
  console.log("news", props.history);
  useEffect(() => {
    
    return () => {
      console.log('clean')
    }
  }, [])
  return (
    <div>
      <button
        onClick={() => {
          let x = count + 1;
          setCount(x);
        }}
      >
        update
      </button>
    </div>
  );
}

export default React.memo(News);
