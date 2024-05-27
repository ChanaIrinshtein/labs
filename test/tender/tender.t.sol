// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/store/store.sol";
import "../../src/NFT/nft.sol";
import "../../src/tender/tender.sol";
import "/home/user/newProject/myToken/script/myToken.sol";

contract TestTender is Test {
    MyNFT public myCoinNFT;
    MyToken public myCoinE;
    Tender public tenderA;
    uint256 wad = 10 ** 18;
    address guy = vm.addr(123);
    uint256 public count = 100 * wad;

    function setUp() public {
        myCoinNFT = new MyNFT();
        myCoinE = new MyToken();
        tenderA = new Tender(address(myCoinNFT), address(myCoinE), count);
    }

    function testAddOffer() public {
        uint256 sum = 200 * wad;
        vm.startPrank(guy);
        myCoinE.approve(address(tenderA), sum);
        myCoinE.mint(address(guy), sum);
        vm.warp(2 days);
        tenderA.addOffer(sum);
        assertEq(tenderA.users(guy), 200 * wad);
        vm.stopPrank();
    }

    function testDontAddOffer() public {
        uint256 sum = 50 * wad;
        vm.startPrank(guy);
        myCoinE.approve(address(tenderA), sum);
        myCoinE.mint(address(guy), sum);
        vm.warp(2 days);
        vm.expectRevert();
        tenderA.addOffer(sum);
        vm.stopPrank();
    }

    function testRemoveOffer() public {
        uint256 sum1 = 200 * wad;
        uint256 sum2 = 300 * wad;
        address user1 = vm.addr(1234);
        address user2 = vm.addr(123);
        address owner = 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496;
        tenderA.setUsers(user1,sum1);
        tenderA.setUsers(user2,sum2);
        vm.startPrank(owner);
        vm.warp(2 days);
        tenderA.removeOffer(user1);
        vm.stopPrank();
    }
}
