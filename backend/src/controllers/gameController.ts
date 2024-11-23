import { Request, Response } from 'express';
import Game from "../models/gameModel";

export const createGame = async (req: Request, res: Response) => {
    const { type, players } = req.body;

    const newGame = new Game({ type, players, score: [0, 0], status: "ongoing", winner: null });

    try {
        await newGame.save();
        res.status(201).json(newGame);
    } catch (error: unknown) {
        if (error instanceof Error) {
            res.status(500).json({ message: error.message });
        } else {
            res.status(500).json({ message: "An unknown error occurred" });
        }
    }
};

export const updateGame = async (req: Request, res: Response): Promise<any> => {
    const { gameId } = req.params;
    const { score, status, winner } = req.body;

    try {
        const game = await Game.findById(gameId);
        if (!game) {
            return res.status(404).json({ message: "Game not found" });
        }

        game.score = score;
        game.status = status;
        game.winner = winner;

        await game.save();
        return res.status(200).json(game);
    } catch (error: unknown) {
        if (error instanceof Error) {
            res.status(500).json({ message: error.message });
        } else {
            res.status(500).json({ message: "An unknown error occurred" });
        }
    }
};
