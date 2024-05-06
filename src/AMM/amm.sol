// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.15;

import "/home/user/newProject/myToken/script/myToken.sol";
import "../../src/AMM/amm.sol";
import "forge-std/console.sol";

contract Amm {
    MyToken tokenA;
    MyToken tokenB;
    uint256 wad = 1e18;
    uint256 public total = 0;
    mapping(address => uint256) public liquidity;
    uint256 public balanceA;
    uint256 public balanceB;
    uint256 sum = 100 * wad;
    constructor(address _tokenA, address _tokenB) {
        tokenA = MyToken(_tokenA);
        tokenB = MyToken(_tokenB);
        address owner = msg.sender;
        tokenA.mint(address(this), sum);
        tokenB.mint(address(this), sum);
        balanceA += sum;
        balanceB += sum;
    }

    function calcCount(uint256 _balanceA, uint256 _balanceB, uint256 amount, uint256 kindOfToken)
        public
        pure
        returns (uint256)
    {
        require(amount > 0, "your sum is zero");
        if (kindOfToken == 1) {
            return (_balanceB * 1e18 / _balanceA) * amount / 1e18;
        }
        return (_balanceA * 1e18 / _balanceB) * amount / 1e18;
    }

    function tradeAToB(uint256 amount) external {
        require(amount > 0, "amount is zero");
        console.log(address(this));
        tokenA.transferFrom(msg.sender, address(this), amount);
        balanceA += amount;
        uint256 balance = calcCount(balanceA, balanceB, amount, 1) / 1e18;
        console.log("balance:    ", balance);
        tokenB.transfer(msg.sender, balance);
        balanceB -= amount;
    }

    function tradeBToA(uint256 amount) external {
        require(amount > 0, "amount is zero");
        console.log(address(this));
        tokenB.transferFrom(msg.sender, address(this), amount);
        balanceB += amount;
        uint256 balance = calcCount(balanceA, balanceB, amount, 1) / 1e18;
        console.log("balance:    ", balance);
        tokenA.transfer(msg.sender, balance);
        balanceA -= amount;
    }
}
