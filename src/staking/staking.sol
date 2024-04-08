// SPDX-License-Identifier: MIT
pragma solidity >=0.8.20;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "/home/user/newProject/myToken/script/myToken.sol";

contract Staking {
    IERC20 public immutable stakingToken;
    MyToken public immutable myCoin;
    uint256 public totalDeposits;
    mapping (address => uint256) public userDeposite; //An array for keeping an amount of coins for each customer
    mapping (address => uint256) public depositeTime; //An array for keeping the coin deposit time for each customer
    uint256 totalSupply = 1000000;

    constructor (address _stakingToken) {
        stakingToken = IERC20(_stakingToken);
        myCoin = new MyToken();
        stakingToken.transfer(address(this), totalSupply);
    }

    function deposite(uint256 amount) external {
        require(amount>0, "You cannot deposit less than 0");
        stakingToken.transfer(address(this),amount); //Depositing an amount of coins to the address of the smart contract
        userDeposite[msg.sender]+= amount;
        depositeTime[msg.sender] = block.timestamp;
        myCoin.mint(msg.sender,amount);
        totalDeposits += amount; //Total user deposits
    }

    function withdraw(uint256 amount) external{
        require(userDeposite[msg.sender]>= amount, "You don't have enough money in your account");
        require(block.timestamp - depositeTime[msg.sender] >= 1 weeks);
        uint256 balance = userDeposite[msg.sender];
        uint256 precent = balance / totalDeposits; //Checking for a certain user what percentage of his coins is out of the total amount in the network
        uint256 reward = totalSupply * precent;
        stakingToken.transferFrom(address(this), msg.sender, reward+amount);///
        totalSupply -= reward;
        userDeposite[msg.sender] -= amount;
    }

    function getBalance() external view returns(uint256) {
        return stakingToken.balanceOf(address(this));
    }
}