import mongoose from "mongoose";

const gameSchema = new mongoose.Schema({
    type: { type: String, required: true },
    players: { type: [String], required: true },
    score: { type: [Number], default: [0, 0] },
    status: { type: String, default: "ongoing" },
    winner: { type: String, default: null },
});

const Game = mongoose.model("Game", gameSchema);
export default Game;
