
import express from "express";
import { updateGame, createGame } from "../controllers/gameController";

const router = express.Router();

router.post("/create", createGame);

router.put("/update/:gameId", updateGame);

export default router;
