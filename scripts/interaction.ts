import { ethers } from "hardhat";

const main = async () => {
  const [beneficiary] = await ethers.getSigners();
  const releaseTime = Math.floor(Date.now() / 1000) + 5;
  const grantAmount = ethers.parseEther("20");

  const GrantVaultContract = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512";
  const GRANT_VAULT_CONTRACT = await ethers.getContractAt(
    "IGrantVault",
    GrantVaultContract
  );

  const offerGrantTx = await GRANT_VAULT_CONTRACT.offerGrant(
    beneficiary,
    releaseTime,
    { value: grantAmount }
  );
  offerGrantTx.wait();

  const claimGrantTx = await GRANT_VAULT_CONTRACT.claimGrant(0);
  claimGrantTx.wait();

  const getGrantTx = await GRANT_VAULT_CONTRACT.getGrant(beneficiary);
  console.log(getGrantTx);

  const getGrantCountTx = await GRANT_VAULT_CONTRACT.getGrantCount(beneficiary);
  console.log(getGrantCountTx);
};

main().catch((error) => {
  console.log(error);
  process.exitCode = 1;
});
