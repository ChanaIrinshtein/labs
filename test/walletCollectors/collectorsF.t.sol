// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../src/Wallet/CollectorsWallet.sol";

contract CollectorsFuzzTest is Test {
    CollectorsWallet public wallet;

    function setUpF(uint256 amount) public {
        wallet = new CollectorsWallet();
        payable(address(wallet)).transfer(amount); 
    }

    function testReceiveF(uint256 amount) public{
        uint256 startBalance= address(wallet).balance;
        payable(address(wallet)).transfer(amount);
        uint finalBalance= address(wallet).balance;
        console.log(finalBalance);
        assertEq(finalBalance, startBalance + amount);
     }

    function testWdIsntAllowdF(uint256 amount) external {
        address userAddress = vm.addr(12); 
        vm.startPrank(userAddress); 
        vm.expectRevert();
        wallet.withdraw(amount);
        vm.stopPrank();
    }
    function testWdAllowedF(uint256 amount, address userAddress) external {
        vm.startPrank(userAddress); 
        uint256 initialBalance = address(wallet).balance;
        wallet.withdraw(amount);
        uint256 finalBalance = address(wallet).balance;
        assertEq(finalBalance, initialBalance - amount);
        vm.stopPrank();
    }

    function testWdWithoutEnoughMoneyF(uint256 amount, address userAddress) public {
        vm.startPrank(userAddress);
        vm.expectRevert();
        wallet.withdraw(amount);
        vm.stopPrank();
    }

    function testUpdateCollectorsF(address oldAddress, address newAddress ) public {
        address addressOwner = address(wallet.owner());
        console.log (address(wallet));
        vm.startPrank(addressOwner);
        wallet.updateCollectors(oldAddress, newAddress);
        assertEq((address(wallet)),0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f);
        assertEq(wallet.collectors(newAddress), 1);
        assertEq(wallet.collectors(oldAddress), 0);
        vm.stopPrank();
    }
      

     function testIsntUpdateCollectorsF(address oldAddress, address newAddress ) public {
        address addressOwner = vm.addr(123);
        console.log (address(wallet));
        vm.startPrank(addressOwner);
        vm.expectRevert();
        wallet.updateCollectors(oldAddress, newAddress);
        assertEq(wallet.collectors(oldAddress), 1);
        vm.stopPrank();
    }

     function testGetBalanceF() public {
        assertEq(wallet.getBalance(), 100, "not equal");
    }
}