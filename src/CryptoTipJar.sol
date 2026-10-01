// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CryptoTipJar {
    address public owner;

    mapping(address => uint256) public tips;

    event TipReceived(address indexed donor, uint256 amount);
    event Withdrawal(address indexed owner, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    function tip() public payable {
        require(msg.value > 0, "Tip must be greater than zero");

        tips[msg.sender] += msg.value;

        emit TipReceived(msg.sender, msg.value);
    }

    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");

        uint256 balance = address(this).balance;

        require(balance > 0, "No funds to withdraw");

        emit Withdrawal(owner, balance);

        (bool success, ) = payable(owner).call{value: balance}("");
        require(success, "Transfer failed");
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}