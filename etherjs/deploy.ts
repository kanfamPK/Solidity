import { ethers } from "ethers";
import * as fs from "fs-extra";
import { config } from "./config";
import * as hexConverter from 'hex2dec';
import 'dotenv/config';

(async function main() {
  const provider = new ethers.providers.JsonRpcProvider(config.rpc);
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);
  const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8");
  const binary = fs.readFileSync(
    "./SimpleStorage_sol_SimpleStorage.bin",
    "utf8"
  );
  const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
  console.log('Deploying contract.....')
  const contract = await contractFactory.deploy();
  // const deploymentReceipt = await contract.deployTransaction.wait(1);
  console.log(`Deploy successfully, contract address: ${contract.address}`);
  await contract.store("5");
  const txFavoriteNumber = await contract.retrieve();
  console.log('Transaction favorite number: ', `${txFavoriteNumber}` );

  // const nonce = await wallet.getTransactionCount();
  // chainId is depend on ganache on each computer, aware about that
  // const tx = {
  //   nonce,
  //   gasPrice: 20000000000,
  //   gasLimit: 1000000,
  //   to: null,
  //   value: 0,
  //   data: "0x" + config.txExampleBinData,
  //   chainId: config.chainId
  // };
  // const signedTx = await wallet.signTransaction(tx);
  // const sentTx = await wallet.sendTransaction(tx);
  // await sentTx.wait(1);
  // console.log('', sentTx);
})()
