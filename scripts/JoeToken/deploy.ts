import { ethers } from "hardhat";

async function main(){
    const JoeToken = await ethers.getContractFactory("JoeToken");
    const joeToken = await JoeToken.deploy();
  
    await joeToken.deployed();
  
    console.log(`Deployed JoeToken Contract Successfully`);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});