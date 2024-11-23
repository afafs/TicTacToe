"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const mongoose_1 = __importDefault(require("mongoose"));
const gameSchema = new mongoose_1.default.Schema({
    type: { type: String, required: true },
    players: { type: [String], required: true },
    score: { type: [Number], default: [0, 0] },
    status: { type: String, default: "ongoing" },
    winner: { type: String, default: null },
});
const Game = mongoose_1.default.model("Game", gameSchema);
exports.default = Game;
