import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";
dotenv.config();



const config: HardhatUserConfig = {
  solidity: "0.8.17",
  networks: {
    sepolia: {
      url: process.env.ethSpeoliaRPC || "",
      accounts: process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
    optimismSepolia: {
      url: process.env.opSepoliaRPC || "",
      accounts: process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
    // Add ZetaChain if supported by your RPC provider
    zetachainAthens: {
      url: process.env.zetaChainRPC || "",
      accounts: process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
    },
  },
};

export default config;
