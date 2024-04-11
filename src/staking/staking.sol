
// SPDX-License-Identifier: MIT
pragma solidity >=0.8.20;
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "/home/user/newProject/myToken/script/myToken.sol";
import "forge-std/console.sol";
struct User{
    uint256 amount;
    uint256 time;
}
contract Staking {
    uint256 wad = 10 ** 18;
    MyToken public immutable myCoin;
    uint256 public totalSupply = 1000000;
    uint256 statePer = 2;
    mapping(address => User) public userStake;
    constructor (address _myCoin) {
        myCoin = MyToken(_myCoin);
        myCoin.mint(address(this), totalSupply);
        // totalSupply *= wad;
    }
     function userStaking(address userAddress) public view returns (User memory) {
        return userStake[userAddress];
    }
    function deposit(uint256 number) external {
        require(number > 0, "You cannot deposit less than 0");
        // myCoin.transfer(address(myCoin),number); //Depositing an amount of coins to the address of the smart contract
        userStake[msg.sender].amount += number;
        userStake[msg.sender].time = block.timestamp;
        console.log("ddddddddddd: ",userStake[msg.sender].amount);
        totalSupply += number; //Total user deposits
        myCoin.mint(address(this),number);
                console.log("ddddddddddd: ",userStake[msg.sender].amount);

        // myCoin.mint(address(msg.sender),number);
    }
    function withdraw(uint256 number) external{ //100
        require(userStake[msg.sender].amount >= number, "You don't have enough money in your account");
        require(block.timestamp - userStake[msg.sender].time >= 1 weeks);
        uint256 reward = this.getReward(number);
        myCoin.transferFrom(address(this), msg.sender, reward+number); //102
        totalSupply -= reward+number;
        userStake[msg.sender].amount -= number;
    }
    function getReward(uint256 number ) external view returns(uint256){
        uint256 precent =  number / totalSupply * 100; // 10%
        uint256 rewardPercent = totalSupply * (statePer / 100); // 20
        uint256 reward = rewardPercent * (precent / 100); //2
        return reward;
    }
    function getBalance() external view returns(uint256) {
        return myCoin.balanceOf(address(this));
    }
}




// pragma solidity >=0.8.20;
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// import "/home/user/newProject/myToken/script/myToken.sol";

// contract Staking {
//     IERC20 public immutable stakingToken;
//     MyToken public immutable myCoin;
//     uint256 public totalDeposits;
//     mapping (address => uint256) public userDeposite; //An array for keeping an amount of coins for each customer
//     mapping (address => uint256) public depositeTime; //An array for keeping the coin deposit time for each customer
//     uint256 totalSupply = 1000000;

//     constructor (address _stakingToken) {
//         stakingToken = IERC20(_stakingToken);
//         myCoin = new MyToken();
//         stakingToken.transfer(address(this), totalSupply);
//     }

//     function deposite(uint256 amount) external {
//         require(amount>0, "You cannot deposit less than 0");
//         stakingToken.transfer(address(this),amount); //Depositing an amount of coins to the address of the smart contract
//         userDeposite[msg.sender]+= amount;
//         depositeTime[msg.sender] = block.timestamp;
//         myCoin.mint(msg.sender,amount);
//         totalDeposits += amount; //Total user deposits
//     }

//     function withdraw(uint256 amount) external{
//         require(userDeposite[msg.sender]>= amount, "You don't have enough money in your account");
//         require(block.timestamp - depositeTime[msg.sender] >= 1 weeks);
//         uint256 balance = userDeposite[msg.sender];
//         uint256 precent = balance / totalDeposits; //Checking for a certain user what percentage of his coins is out of the total amount in the network
//         uint256 reward = totalSupply * precent;
//         stakingToken.transferFrom(address(this), msg.sender, reward+amount);///
//         totalSupply -= reward;
//         userDeposite[msg.sender] -= amount;
//     }

//     function getBalance() external view returns(uint256) {
//         return stakingToken.balanceOf(address(this));
//     }
// }