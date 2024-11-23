import { Request, Response } from "express";
import User from "../models/userModel";
import jwt from "jsonwebtoken";

export const createUser = async (req: Request, res: Response): Promise<any> => {
    const { email, password } = req.body;

    const userExists = await User.findOne({ email });
    if (userExists) {
        return res.status(400).json({ message: "User already exists" });
    }

    const user = new User({ email, password });
    try {
        await user.save();
        res.status(201).json({ message: "User created successfully" });
    } catch (error: unknown) {
        if (error instanceof Error) {
            res.status(500).json({ message: error.message });
        } else {
            res.status(500).json({ message: "An unknown error occurred" });
        }
    }
};

export const loginUser = async (req: Request, res: Response): Promise<any> => {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
        return res.status(400).json({ message: "Invalid credentials" });
    }

    const isMatch = await user.matchPassword(password);
    if (!isMatch) {
        return res.status(400).json({ message: "Invalid credentials" });
    }

    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET || "secret", { expiresIn: "1h" });
    res.json({ token });
};
