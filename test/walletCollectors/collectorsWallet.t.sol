// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../src/wallet/collectorsWallet.sol";

contract CollectorsTest is Test {
    CollectorsWallet public wallet;

    function setUp() public {
        wallet = new CollectorsWallet();
        payable(address(wallet)).transfer(100); 
    }

    function testReceive() public{
        uint256 startBalance= address(wallet).balance;
        payable(address(wallet)).transfer(500);
        uint finalBalance= address(wallet).balance;
        console.log(finalBalance);
        assertEq(finalBalance, startBalance + 500);
     }

    function testWdIsntAllowd() external {
        uint256 amount = 50;
        address userAddress = vm.addr(12); 
        vm.startPrank(userAddress); 
        vm.expectRevert();
        wallet.withdraw(amount);
        vm.stopPrank();
    }
    function testWdAllowed() external {
        uint256 amount = 50;
        address userAddress = 0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f; 
        vm.startPrank(userAddress); 
        uint256 initialBalance = address(wallet).balance;
        console.log("ttttttttt:",address(wallet));
        wallet.withdraw(amount);
        uint256 finalBalance = address(wallet).balance;
        assertEq(finalBalance, initialBalance - amount);
        vm.stopPrank();
    }

    function testWdWithoutEnoughMoney() public {
        uint256 amount = 500;
        address userAddress = 0x7a3b914a1f0bD991BAf826F4fE9a47Bb9880d25f; 
        vm.startPrank(userAddress);
        vm.expectRevert();
        wallet.withdraw(amount);
        vm.stopPrank();
    }

    function testUpdateCollectors() public {
        address oldAddress = 0xaC4E320Ed1235F185Bc6AC8856Ec7FEA7fF0310d;
        address newAddress = vm.addr(123);
        address addressOwner = address(wallet.owner());
        console.log (address(wallet));
        vm.startPrank(addressOwner);
        wallet.updateCollectors(oldAddress, newAddress);
        assertEq((address(wallet)),0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f);
        assertEq(wallet.collectors(newAddress), 1);
        assertEq(wallet.collectors(oldAddress), 0);
        vm.stopPrank();
    }
      

     function testIsntUpdateCollectors() public {
        address oldAddress = 0xaC4E320Ed1235F185Bc6AC8856Ec7FEA7fF0310d;
        address newAddress = 0x7ae3DbAC75D264B6F6976639ebBfC645601D3F15;
        address addressOwner = vm.addr(123);
        console.log (address(wallet));
        vm.startPrank(addressOwner);
        vm.expectRevert();
        wallet.updateCollectors(oldAddress, newAddress);
        assertEq(wallet.collectors(oldAddress), 1);
        vm.stopPrank();
    }

     function testGetBalance() public {
        assertEq(wallet.getBalance(), 100, "not equal");
    }
}