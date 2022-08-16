import("@nomiclabs/hardhat-waffle");
import("hardhat-gas-reporter");
import("@nomiclabs/hardhat-etherscan");
import "dotenv/config";
import "solidity-coverage";
import "@typechain/hardhat";
import "@nomiclabs/hardhat-ethers";
import { task, HardhatUserConfig } from "hardhat/config"

const config: HardhatUserConfig = {
  defaultNetwork: "hardhat",
  networks: {
    rinkeby: {
      url: "https://eth-rinkeby.alchemyapi.io/v2/mRTunZyOSlnIcyqHdSYSic2VPSd0gpqA",
      accounts: [process.env.RINKEBY_PRIVATE_KEY || ''],
      chainId: 4
    }
  },
  solidity: "0.8.9",
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
    customChains: [
      {
        network: "rinkeby",
        chainId: 4,
        urls: {
          apiURL: "https://api-rinkeby.etherscan.io/api",
          browserURL: "https://rinkeby.etherscan.io"
        }
      }
    ]
  }
};

export default config;
