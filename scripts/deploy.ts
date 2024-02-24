import { ethers } from "hardhat";

async function main() {
  const GrantVault = await ethers.deployContract("GrantVault");

  await GrantVault.waitForDeployment();

  console.log(`GrantVault has been deployed to ${GrantVault.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
