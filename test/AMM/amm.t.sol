// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "/home/user/newProject/myToken/script/myToken.sol";
import "../../src/AMM/amm.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

contract TestAmm is Test {
    MyToken tokenA;
    MyToken tokenB;
    Amm amm;
    uint256 wad = 1e18;

    function setUp() public {
        tokenA = new MyToken();
        tokenB = new MyToken();
        amm = new Amm(address(tokenA), address(tokenB));
    }

    function testCalcCount() public {
        console.log(amm.calcCount(60 * wad, 50 * wad, 10 * wad, 1) / wad);
        console.log(amm.calcCount(60 * wad, 50 * wad, 10 * wad, 2) / wad);
        assertEq(amm.calcCount(60 * wad, 50 * wad, 10 * wad, 1), 8333333333333333330);
        assertEq(amm.calcCount(60 * wad, 50 * wad, 10 * wad, 2), 12000000000000000000);
    }

    // function testCalcLiquidity() public {
    //     console.log(amm.calcLiquidity(500 * wad, 100 * wad, 20 * wad, 1) / wad);
    //     // console.log("gggggggg");
    // }

    function testTradeAToB() external {
        uint256 amount = 50 * wad;
        tokenA.mint(address(this), amount);
        tokenA.approve(address(amm), amount);
        tokenB.mint(address(amm), amount);
        amm.tradeAToB(amount);
    }

    function testTradeBToA() external {
        uint256 amount = 50 * wad;
        tokenB.mint(address(this), amount);
        tokenB.approve(address(amm), amount);
        tokenA.mint(address(amm), amount);
        amm.tradeBToA(amount);
    }

    // function testAddLiquidityA() external {
    //     uint256 sum = 20 * wad;
    //     uint256 amount = 50 * wad;
    //     address user = vm.addr(123);
    //     vm.startPrank(user);
    //     console.log("msgmsg", user);
    //     tokenA.approve(address(user), amount);
    //     tokenA.mint(address(user), amount);
    //     tokenB.approve(address(user), amount);
    //     tokenB.mint(address(user), amount);
    //     amm.AddLiquidityA(sum);
    //     // console.log(calcLiquidity())
    // }
}
