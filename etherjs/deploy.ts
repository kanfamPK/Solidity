import { ethers } from "ethers";
import * as fs from "fs-extra";
import { config } from "./config";

async function main() {
  const provider = new ethers.providers.JsonRpcProvider(config.rpc);
  const wallet = new ethers.Wallet(config.privateKey, provider);
  const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8");
  const binary = fs.readFileSync(
    "./SimpleStorage_sol_SimpleStorage.bin",
    "utf8"
  );
  const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
  const contract = await contractFactory.deploy();
  const deploymentReceipt = await contract.deployTransaction.wait(1);

  // chainId is depend on ganache on each computer, aware about that
  const tx = {
    nonce: 5,
    gasPrice: 20000000000,
    gasLimit: 1000000,
    to: null,
    value: 0,
    data: "0x" + config.txExampleBinData,
    chainId: 5777
  };
  const signedTx = await wallet.signTransaction(tx);
  const sentTx = await wallet.sendTransaction(tx);
  await sentTx.wait(1);
  console.log('', sentTx);
}

main();
