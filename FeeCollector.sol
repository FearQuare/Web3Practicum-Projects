// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract FeeCollector {
    address public owner;
    uint256 public balance;

    constructor() {
        owner = msg.sender;
    }

    receive() payable external { //This function will be called whenever somebody sends money to the smart contract.
        balance += msg.value;
    }

    function withdraw(uint amount, address payable destAddr) public { //because we made the visibility public, anybody who knows the address of the smart contract can withdraw money.
        //To make this secure, this function needs to be called by owner.
        require(msg.sender == owner, "Only owner can withdraw");
        require(amount <= balance, "Insufficent funds");
        destAddr.transfer(amount); //Every payable address has function transfer()
        balance -= amount;
    }
}