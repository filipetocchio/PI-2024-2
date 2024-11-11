import { prisma } from '../../utils/prisma';
import { Request, Response } from "express";
import { AuthRouteResponse, RouteResponse } from "../../interfaces/interfaces";
import { ZodError } from "zod";
import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";
import dotenv from "dotenv";

dotenv.config();

async function postTbUsuario(req: Request, res: Response) {
  try {
    const { username, password, email } = req.body;

    const duplicate = await prisma.tbUsuario.findFirst({
      where: { OR: [{ username: username }, { email: email }] },
    });
    if (duplicate) {
      const response: RouteResponse<null> = {
        code: 409,
        data: null,
        success: false,
        error: "This username or email is already in use.",
        message: "This username or email is already in use.",
      };
      res.status(response.code).json(response);
      return;
    }
    
    if (username.length < 1) {
      const response: RouteResponse<null> = {
      code: 400,
      data: null,
      success: false,
      error: "Username is a required field.",
      message: "Username is a required field.",
      };
      res.status(response.code).json(response);
      return;
    }
    if (username.length > 20) {
      const response: RouteResponse<null> = {
      code: 400,
      data: null,
      success: false,
      error: "Username cannot exceed 20 characters.",
      message: "Username cannot exceed 20 characters.",
      };
      res.status(response.code).json(response);
      return;
    }

    if (password.length < 6) {
      const response: RouteResponse<null> = {
      code: 400,
      data: null,
      success: false,
      error: "Password must be at least 6 characters.",
      message: "Password must be at least 6 characters.",
      };
      res.status(response.code).json(response);
      return;
    }

    const hashedPassword: string = await bcrypt.hash(password, 10);

    const accessToken = jwt.sign({ UserInfo: { username: username } }, process.env.ACCESS_TOKEN_SECRET, {
      expiresIn: "6h",
    });
    const refreshToken = jwt.sign({ username: username }, process.env.REFRESH_TOKEN_SECRET, {
      expiresIn: "1d",
    });

    const user = await prisma.tbUsuario.create({
      data: {
        email: email,
        username: username,
        password: hashedPassword,
        refreshToken: refreshToken,
      },
    });

    res.cookie("jwt", refreshToken, {
      domain: "http://localhost:4200",
      path: "/",
      httpOnly: true,
      sameSite: "lax",
      secure: true,
      maxAge: 24 * 60 * 60 * 1000,
    });

    const response: RouteResponse<AuthRouteResponse> = {
      success: true,
      message: `New user ${username} created.`,
      code: 201,
      error: null,
      data: {
        accessToken: accessToken,
        username: user.username,
        id: user.id,
      },
    };
    
    res
      .cookie("jwt", refreshToken, {
        httpOnly: true,
        secure: true,
        maxAge: 24 * 60 * 60 * 1000,
      })
      .status(response.code)
      .json(response);
  } catch (error) {

    const response: RouteResponse<null> = {
      code: 500,
      data: null,
      success: false,
      error: "Internal server error.",
      message: "Internal server error.",
    };
    if (error instanceof ZodError) {
      response.code = 400;
      response.error = error.errors[0].message;
      response.message = error.errors[0].message;
      res.status(response.code).json(response);
      return;
    }
    res.status(response.code).json(response);
  }
}

const postLoginTbUsuario = async (req: Request, res: Response) => {
  try {
    const { username, password } = req.body;

    if (!username) {
      return res.status(422).json({ msg: 'username is required!' });
    }

    if (!password) {
      return res.status(422).json({ msg: 'Password is required!' });
    }

    const foundUser = await prisma.tbUsuario.findFirst({ where: { username: username } });

    if (!foundUser) {
      const response: RouteResponse<null> = {
        code: 401,
        data: null,
        success: false,
        error: "No user found with this username.",
        message: "No user found with this username.",
      };
      return res.status(response.code).json(response);
    }

    const match = await bcrypt.compare(password, foundUser.password);

    if (match) {
      const accessToken = jwt.sign({ UserInfo: { username: foundUser.username } }, process.env.ACCESS_TOKEN_SECRET, {
        expiresIn: "6h",
      });

      const refreshToken = jwt.sign({ username: foundUser.username }, process.env.REFRESH_TOKEN_SECRET, {
        expiresIn: "1d",
      });

      await prisma.tbUsuario.update({ where: { id: foundUser.id }, data: { refreshToken: refreshToken } });

      res.header("Access-Control-Allow-Credentials: true");
      res.header("Access-Control-Allow-Origin", "*");
      res.header("Access-Control-Allow-Headers", "*");

      res.cookie("jwt", refreshToken, {
        httpOnly: true,
        sameSite: "lax",
        secure: true,
        maxAge: 24 * 60 * 60 * 1000,
      });

      const response: RouteResponse<AuthRouteResponse> = {
        code: 200,
        success: true,
        error: null,
        message: `User ${username} successfully logged in`,
        data: {
          id: foundUser.id,
          username: foundUser.username,
          accessToken: accessToken,
        },
      };
      return res.status(response.code).json(response);
    } else {
      const response: RouteResponse<null> = {
        code: 401,
        data: null,
        success: false,
        error: "The password is incorrect.",
        message: "The password is incorrect.",
      };
      return res.status(response.code).json(response);
    }
  } catch (error) {
    const response: RouteResponse<null> = {
      code: 400,
      data: null,
      success: false,
      error: "Internal server error.",
      message: "Internal server error.",
    };
    if (error instanceof ZodError) {
      response.error = error.errors[0].message;
      response.message = error.errors[0].message;
      return res.status(response.code).json(response);
    }
    res.status(response.code).json(response);
  }
};

export { postTbUsuario, postLoginTbUsuario };