require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("./tasks/PrintAccounts");

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  defaultNetwork: "localhost",
  networks: {
    hardhat: {
      chainId: 31337,
    },
    /* 
      rinkeby: {
        url: "https://eth-rinkeby.alchemyapi.io/v2/123abc123abc123abc123abc123abcde",
        accounts: [privateKey1, privateKey2, ...]
      } 
      localhost: {
        url: `http://localhost:8545`,
        accounts: [`${process.env.REACT_APP_LOCAL_PRV_KEY}`],
        timeout: 150000,
        chainId: 31337,
        // gasPrice: parseInt(utils.parseUnits("132", "gwei")),
      },
    */
  },
  // etherscan: {
  //   apiKey: process.env.REACT_APP_POLYGONSCAN_API_KEY,
  // },
  solidity: {
    compilers: [
      {
        version: "0.8.4",
      },
    ],
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  mocha: {
    timeout: 20000,
  },
};
