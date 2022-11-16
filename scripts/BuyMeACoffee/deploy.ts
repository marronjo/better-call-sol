import { ethers } from "hardhat";

async function main(){
    const BuyMeACoffee = await ethers.getContractFactory("BuyMeACoffee");
    const buyMeACoffee = await BuyMeACoffee.deploy();
  
    await buyMeACoffee.deployed();
  
    console.log(`Deployed BuyMeACoffee Contract Successfully to ${buyMeACoffee.address}`);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});