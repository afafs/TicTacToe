"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const dotenv_1 = __importDefault(require("dotenv"));
const cors_1 = __importDefault(require("cors"));
const db_1 = require("./config/db");
const userRoutes_1 = __importDefault(require("./routes/userRoutes"));
const gameRoutes_1 = __importDefault(require("./routes/gameRoutes"));
const http_1 = __importDefault(require("http"));
const socket_io_1 = require("socket.io"); // Correct import
dotenv_1.default.config();
// Initialize app and server
const app = (0, express_1.default)();
const server = http_1.default.createServer(app);
const io = new socket_io_1.Server(server); // Correct initialization
// Middleware
app.use((0, cors_1.default)());
app.use(express_1.default.json());
// MongoDB connection
(0, db_1.connectDB)();
// Routes
app.use("/api/users", userRoutes_1.default);
app.use("/api/games", gameRoutes_1.default);
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
