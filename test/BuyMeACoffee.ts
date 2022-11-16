import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { Address } from "cluster";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";

describe("BuyMeACoffee", function () {
  async function deployBuyMeACoffeeContract() {

    const [owner, otherAccount] = await ethers.getSigners();
    const BuyMeACoffee = await ethers.getContractFactory("BuyMeACoffee");
    const buyMeACoffee = await BuyMeACoffee.deploy();

    return { buyMeACoffee, owner, otherAccount };
  }

//   function clearAddress(clearAccount: SignerWithAddress, recipient: SignerWithAddress) {
//     recipient.sendTransaction(clearAccount.getBalance());
//   }

  describe("Deployment", function () {
    // it("Should fail if the unlockTime is not in the future", async function () {
    //     // We don't use the fixture here because we want a different deployment
    //     const { buyMeACoffee, otherAccount } = await loadFixture(deployBuyMeACoffeeContract);
    //     await expect(buyMeACoffee.buyCoffee).to.be.revertedWith(
    //       "Unlock time should be in the future"
    //     );
    // });

    it("Should set the right unlockTime", async function () {
      const { lock, unlockTime } = await loadFixture(deployBuyMeACoffeeContract);

      expect(await lock.unlockTime()).to.equal(unlockTime);
    });

    it("Should set the right owner", async function () {
      const { lock, owner } = await loadFixture(deployBuyMeACoffeeContract);

      expect(await lock.owner()).to.equal(owner.address);
    });

    it("Should receive and store the funds to lock", async function () {
      const { lock, lockedAmount } = await loadFixture(deployBuyMeACoffeeContract);

      expect(await ethers.provider.getBalance(lock.address)).to.equal(
        lockedAmount
      );
    });
  });
});