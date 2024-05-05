pragma solidity >=0.7.0 <0.9.0;

contract Wallet {
    address public owner;
    address[] public owners;

    //the funcion do a counting
    receive() external payable {}

    constructor() {
        owner = msg.sender;
    }

    modifier isOwner() {
        bool delegate = false;
        for (uint256 i = 0; i < owners.length; i++) {
            if (msg.sender == owners[i]) {
                delegate = true;
                break;
            }
        }
        require(delegate, "WALLET-no-owner");
        _;
    }

    function withDraw(uint256 num) public isOwner {
        payable(msg.sender).transfer(num);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function addOwners(address NewOwner) public {
        uint256 count = 0;
        require(msg.sender == owner, "WALLET-no-owner");
        require(count < 3, "you have enough delagetes");
        count++;
        owners.push(NewOwner);
    }
}
