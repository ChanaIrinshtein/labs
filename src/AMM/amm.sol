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
        // address owner = msg.sender;
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

    // function calcLiquidity(uint256 _balanceA, uint256 _balanceB, uint256 amount, uint256 kindOfToken) public returns(uint256){
    //     if (_balanceA > _balanceB) {
    //         uint256 x = _balanceA * 1e18 / _balanceB / 1e18;
    //         uint256 relativityB = x;
    //         kindOfToken == 1}
        //     if (kindOfToken == 1) {
        //         uint256 resultA = amount;
        //         uint256 resultB = amount * x;
        //     }
        //     else{
        //         uint256 resultB = amount;
        //         uint256 resultA = amount * x;
        //     }
        //        return resultA;
        // } else {
        //     uint256 x = _balanceA * 1e18 / _balanceB / 1e18;
        //     uint256 relativityB = x;
        //     if (kindOfToken == 2) {
        //         uint256 resultA = amount;
        //         uint256 resultB = amount * x;
        //     }
        //     else{
        //         uint256 resultB = amount;
        //         uint256 resultA = amount * x;
        //     }
        //        return resultB;
        // }
    // }

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

    // function AddLiquidityA(uint256 amount) external {
    //     console.log("sum", amount / wad);
    //     console.log("111111", address(this));
    //     require(tokenA.balanceOf(msg.sender) / wad > amount / wad, "you dont have engouh amount in your account");
    //     console.log("ssssssssssss", tokenA.balanceOf(msg.sender) / wad);
    //     uint256 balance = calcLiquidity(500 * wad, 100 * wad, 20 * wad, 1) / wad;
    //     console.log("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&",balance);
    //     // uint256 balance = calcCount(balanceA, balanceB, amount, 1) / 1e18;
    //     // console.log("bbbbbbbbbbbbbbbbbbb",balance);
    //     // tokenA.transferFrom(msg.sender, address(this), amount);
    //     // balanceA += amount;
    //     // uint256 balance = calcCount(balanceA, balanceB, amount, 1) / 1e18;
    //     // console.log("balance:    ", balance);
    //     // tokenB.transferFrom(msg.sender, address(this), balance);
    //     // balanceB += amount;
    //     // liquidity[msg.sender] += amount;
    // }
}
