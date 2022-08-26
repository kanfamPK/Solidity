import { HardhatRuntimeEnvironment } from "hardhat/types";

export default async (hre: HardhatRuntimeEnvironment) => {
  // @ts-ignore
  const { getNamedAccounts, deployments, network } = hre;
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();
  const chainId: number = network.config.chainId!;

  // args is the args that will be passed into contract's contructor
  const fundMe = await deploy("FundMe", {
    from: deployer,
    args: [],
    log: true,
  });
};
