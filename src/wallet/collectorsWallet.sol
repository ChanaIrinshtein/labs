// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24 <0.9.0;

import "forge-std/console.sol";

contract CollectorsWallet {
    address payable public owner;

    mapping(address => uint256) public collectors;

    constructor() {
        owner = payable(msg.sender);
        console.log(owner, "owner");
        collectors[0xaC4E320Ed1235F185Bc6AC8856Ec7FEA7fF0310d] = 1;
        collectors[0x7c0FA5571c4A1A67FD21Ed9209674868cC8dc86b] = 1;
        collectors[0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f] = 1;
    }

    modifier isOwner() {
        require(owner == msg.sender, "You arnot the owner");
        _;
    }

    receive() external payable {}

    function withdraw(uint256 amount) external {
        require(owner == msg.sender || collectors[msg.sender] == 1, "You are not allowed");
        require(amount > 0, "you cant withdraw zero");
        require(address(this).balance >= amount, "you dont have enough money");
        payable(msg.sender).transfer(amount);
    }

    function updateCollectors(address oldAddress, address newAddress) external isOwner {
        require(collectors[oldAddress] == 1, "old Collector not exist");
        require(collectors[newAddress] == 0, "a collector is exsist");
        collectors[newAddress] = 1;
        collectors[oldAddress] = 0;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
