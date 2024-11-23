import mongoose, { Document } from "mongoose";
import bcrypt from "bcryptjs";

// Define the User schema interface
interface IUser extends Document {
    email: string;
    password: string;
    matchPassword: (enteredPassword: string) => Promise<boolean>;
}

// User Schema
const userSchema = new mongoose.Schema<IUser>({
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
});

// Hash password before saving user
userSchema.pre("save", async function (next) {
    if (!this.isModified("password")) return next();
    const salt = await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(this.password, salt);
    next();
});

// Method to compare password
userSchema.methods.matchPassword = async function (enteredPassword: string) {
    return await bcrypt.compare(enteredPassword, this.password);
};

const User = mongoose.model<IUser>("User", userSchema);
export default User;
