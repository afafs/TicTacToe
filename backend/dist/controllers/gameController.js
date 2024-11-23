"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.updateGame = exports.createGame = void 0;
const gameModel_1 = __importDefault(require("../models/gameModel"));
const createGame = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { type, players } = req.body;
    const newGame = new gameModel_1.default({ type, players, score: [0, 0], status: "ongoing", winner: null });
    try {
        yield newGame.save();
        res.status(201).json(newGame);
    }
    catch (error) {
        if (error instanceof Error) {
            res.status(500).json({ message: error.message });
        }
        else {
            res.status(500).json({ message: "An unknown error occurred" });
        }
    }
});
exports.createGame = createGame;
const updateGame = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { gameId } = req.params;
    const { score, status, winner } = req.body;
    try {
        const game = yield gameModel_1.default.findById(gameId);
        if (!game) {
            return res.status(404).json({ message: "Game not found" });
        }
        game.score = score;
        game.status = status;
        game.winner = winner;
        yield game.save();
        return res.status(200).json(game);
    }
    catch (error) {
        if (error instanceof Error) {
            res.status(500).json({ message: error.message });
        }
        else {
            res.status(500).json({ message: "An unknown error occurred" });
        }
    }
});
exports.updateGame = updateGame;
