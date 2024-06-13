// // SPDX-License-Identifier: MIT
// pragma solidity >=0.8.24;

// import "../NFT/nft.sol";
// import "forge-std/console.sol";
// import "/home/user/newProject/myToken/script/myToken.sol";

// contract Tender {
//     address payable public owner;
//     mapping(address => uint256) public users;
//     mapping(uint256 => address) public counter;
//     int256 wad = 10 ** 18;
//     MyNFT public immutable myCoinNFT;
//     MyToken public immutable myCoineE;
//     address public maxValue;
//     uint256 public start = 0;
//     uint256 public duration = 7 days;
//     // uint256 public start = block.timestamp;
//     uint256 public count;
//     bool public finish = false;

//     constructor(address _myCoinNFT, address _myCoineE, uint256 amount) {
//         myCoinNFT = MyNFT(_myCoinNFT);
//         myCoineE = MyToken(_myCoineE);
//         owner = payable(msg.sender);
//         console.log("ooooooooooooooooooooooooooo", owner);
//         users[owner] = amount;
//         maxValue = owner;
//     }

//     modifier openTender() {
//         require(block.timestamp < duration, "time is finish");
//         _;
//     }

//     modifier isOwner() {
//         require(msg.sender == owner, "you dont owner");
//         _;
//     }

//     function setUsers(address user, uint256 amount) external {
//         users[user] = amount;
//         console.log("users[user]", users[user]);
//         console.log("user", user);
//         console.log("user", msg.sender);
//     }

//     function addOffer(uint256 amount) external {
//         if (block.timestamp < duration) {
//             require(amount > 0, "amount is zero");
//             require(amount > users[maxValue], "your offer is less from max offer");
//             maxValue = msg.sender;
//             users[maxValue] = amount;
//             counter[count] = msg.sender;
//             myCoineE.transferFrom(msg.sender, address(this), amount);
//             users[msg.sender] = amount;
//             console.log(users[msg.sender]);
//             count++;
//         } else if (!finish) {
//             endTender();
//         }
//     }

//     function removeOffer(address user) external isOwner openTender {
//         console.log("owner", users[owner]);
//         console.log("users[user]", users[user]);
//         console.log("users[maxValue]", users[maxValue]);
//         require(users[user] < users[maxValue], "you cannot cancel offer becuse your offer is higher");
//         users[user] = 0;
//         console.log("usususususus", users[user]);
//     }

//     function endTender() public {
//         myCoinNFT.transferFrom(address(this), address(maxValue), 1);
//         while (count > 0) {
//             address currentAddress = counter[count - 1];
//             uint256 val = myCoinNFT.balanceOf(address(currentAddress));
//             myCoineE.transferFrom(address(this), msg.sender, val);
//             count--;
//         }
//         finish = true;
//     }
// }
