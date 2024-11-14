import React, { useEffect, useState } from "react";
import { fetchData } from "./api";

export default function App() {
  const [data, setData] = useState(null);

  useEffect(() => {
    fetchData().then((response) => setData(response));
  }, []);

  return (
    <View>
      <Text>{data ? "Server Response: " + data : "Loading..."}</Text>
    </View>
  );
}
