import {
    loadFixture,
  } from "@nomicfoundation/hardhat-toolbox/network-helpers";
  import { expect } from "chai";
  import { ethers } from "hardhat";
  
  describe("GeneralSavings", function () {
    // We define a fixture to reuse the same setup in every test.
    // We use loadFixture to run this setup once, snapshot that state,
    // and reset Hardhat Network to that snapshot in every test.
    async function deployGeneralSavings() {
     
  
      // Contracts are deployed using the first signer/account by default
      const [owner, otherAccount] = await ethers.getSigners();

      const SavingsToken = await ethers.getContractFactory("SavingsToken");
      const deployedSavingsToken = await SavingsToken.deploy(100)  

      const GeneralSavings = await ethers.getContractFactory("GeneralSavings");
      const deployedGeneralSavings = await GeneralSavings.deploy(deployedSavingsToken.target);
  
      return { deployedSavingsToken, deployedGeneralSavings, owner, otherAccount };
    }
  
    // DepositEtherFunctionTest
    describe("Deposit", function () {
        it(
          "On deposit of ether into the contract the balance of the depositor should increase by the amount deposited"
        ,
          async function () {
            const { deployedGeneralSavings, owner } = await loadFixture(deployGeneralSavings);
            await deployedGeneralSavings.depositEther({ value: 1 });
            const savingsBalance = await deployedGeneralSavings.checkSaverEtherBalance(owner)
            expect(savingsBalance).to.equal(1)
          })

            it(
              "On deposit of ether into the contract the balance of the depositor should increase by the amount deposited"
            ,
              async function () {
                const { deployedGeneralSavings, owner } = await loadFixture(deployGeneralSavings);
                await deployedGeneralSavings.depositEther({ value: 1 });
                const savingsBalance = await deployedGeneralSavings.checkSaverEtherBalance(owner)
                expect(savingsBalance).to.equal(1)
              })
      });

    //   WithdrawEtherTest

  describe("withdraw", function () {
    it("On withdraw of an amount it should be deducted from the signers balance", async function () {
      const { deployedGeneralSavings, owner } = await loadFixture(deployGeneralSavings);
      await deployedGeneralSavings.depositEther({ value: 2});
      const availbleBalanceBeforeWithdrawal = await deployedGeneralSavings.checkSaverEtherBalance(owner)
      await deployedGeneralSavings.withdrawEther(BigInt(1))
      const availbleBalanceAfterWithdrawal = await deployedGeneralSavings.checkSaverEtherBalance(owner)
      console.log(availbleBalanceAfterWithdrawal)
      console.log(availbleBalanceBeforeWithdrawal)
      expect(BigInt(availbleBalanceAfterWithdrawal)).to.eq(BigInt(availbleBalanceBeforeWithdrawal) - BigInt(1))
    })
  })    
  });
  