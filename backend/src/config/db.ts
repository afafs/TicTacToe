import mongoose from 'mongoose';
import dotenv from 'dotenv';

dotenv.config();

export const connectDB = async () => {
    try {
        await mongoose.connect(
            process.env.MONGODB_URI ?? "mongodb://admin:jh2kn3ggjhgjg5j@185.145.253.28:27017/tictactoedb"
        );
        console.log('MongoDB connected successfully!');
    } catch (err) {
        console.error('Error connecting to MongoDB:', err);
        process.exit(1); // Exit process with failure
    }
};
