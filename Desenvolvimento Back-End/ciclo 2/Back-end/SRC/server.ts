import express from 'express';
import { apiV1Router } from "./routers/routes"
import path from "path";
import { errorHandler } from "./middlewares/errorHandler";

const app = express();
const PORT = process.env.PORT || 8001;

app.use(express.static(path.join(__dirname, "/public")));
app.use("/api/v1", apiV1Router);

app.get("/", (req, res) => {
  res.send("Hello nodejs!");
});

app.use(errorHandler);

app.listen(PORT, () =>
    console.log(`Server is running on port ${PORT}`)
);