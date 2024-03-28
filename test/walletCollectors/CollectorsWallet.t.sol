// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../src/Wallet/CollectorsWallet.sol";
contract CollectorsTest is Test {
    CollectorsWallet public wallet;
    function setUp() public {
        wallet = new CollectorsWallet();
        payable(address(wallet)).transfer(100); // Transfer 100 to a contract
    }

    function testReceive() public{
        uint256 startBalance= address(wallet).balance;
        console.log(startBalance);
        payable(address(wallet)).transfer(500);
        uint finalBalance= address(wallet).balance;
        console.log(finalBalance);
        assertEq(finalBalance, startBalance + 500);
     }

    function testNotAllowedWd() external {
        uint256 withdrawAmount = 50;
        address userAddress = vm.addr(12); // address of not allowed user
        vm.startPrank(userAddress); // send from random address
        vm.expectRevert();
        wallet.withdraw(withdrawAmount);
        vm.stopPrank();
    }
    function testAllowedWd() external {
        uint256 withdrawAmount = 50;
        address userAddress = 0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f; // address of allowed user
        vm.startPrank(userAddress); // send from random address
        console.log(address(userAddress).balance);
        uint256 initialBalance = address(wallet).balance; // the balance in the begining (before transfer)
        wallet.withdraw(withdrawAmount);
        uint256 finalBalance = address(wallet).balance; // the balance in the final (after transfer)
        assertEq(finalBalance, initialBalance - withdrawAmount);
        vm.stopPrank();
    }

   


}