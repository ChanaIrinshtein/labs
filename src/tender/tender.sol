// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;
import "../NFT/nft.sol";
import "forge-std/console.sol";

contract Tender {
    address payable public owner;
    mapping(address => uint256) users;
    mapping(uint256 => address) counter;
    int256 wad = 10 ** 18;
    MyNFT public immutable myCoin;
    address public maxValue;
    uint256 public start = 0;
    uint256 public duration = 7 days; 
    uint256 public count;
    bool public finish = false;

    constructor(address _myCoin) {
        myCoin = MyNFT(_myCoin);
        owner = payable(msg.sender);
        users[owner] = 100;
        maxValue = owner;
    }

    receive() external payable {}

    modifier openTender() {
        require(block.timestamp > duration, "time is finish");
        _;
    }

    modifier isOwner() {
        require(msg.sender == owner, "you dont owner");
        _;
    }

    function addOffer(uint256 amount) external {
        if (block.timestamp > duration) {
            require(amount > 0, "amount is zero");
            require(amount > users[maxValue], "your offer is less from max offer");
            maxValue = msg.sender;
            counter[count] = msg.sender;
            myCoin.transferFrom(msg.sender, address(this), amount);
            users[msg.sender] = amount;
            count++;
        } else if (!finish) {
            endTender();
        }
    }

    function removeOffer(address user) external isOwner openTender {
        require(users[user] < users[maxValue], "you cannot cancel offer becuse your offer is higher");
        users[user] = 0;
    }

    function endTender() public {
        myCoin.transferFrom(address(this),address(maxValue), 1);
        while (count > 0) {
            address currentAddress = counter[count - 1];
            // address ad = users[currentAddress];
            uint256 val = myCoin.balanceOf(address(currentAddress));
            payable(msg.sender).transfer(val);
            // myCoin.transferFrom(msg.sender,address(currentAddress), val);
            count--;
        }
        finish = true;
    }
}
