// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";



const MulticallModule = buildModule("MulticallModule", (m) => {


  const multicall = m.contract("Multicall");

  return { multicall };
});

export default MulticallModule;
