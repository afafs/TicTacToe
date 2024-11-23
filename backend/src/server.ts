import express from "express";
import dotenv from "dotenv";
import cors from "cors";
import { connectDB } from "./config/db";
import userRoutes from "./routes/userRoutes";
import gameRoutes from "./routes/gameRoutes";
import http from "http";
import { Server as socketIo } from "socket.io";  // Correct import

dotenv.config();

// Initialize app and server
const app = express();
const server = http.createServer(app);
const io = new socketIo(server);  // Correct initialization

// Middleware
app.use(cors());
app.use(express.json());

// MongoDB connection
connectDB();

// Routes
app.use("/api/users", userRoutes);
app.use("/api/games", gameRoutes);

// WebSocket logic
io.on("connection", (socket) => {
    console.log("New WebSocket connection:", socket.id);

    socket.on("disconnect", () => {
        console.log("User disconnected");
    });
});

// Start the server
const PORT = process.env.PORT || 5001;
server.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
