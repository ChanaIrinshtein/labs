// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract ReceiveEther {
    //if msg.sender is empty
    receive() external payable {}

    // if msg.sender isnt empty
    fallback() external payable {}

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

contract SendEther {
    function sendViaTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        bool sent = _to.send(msg.value);
        require(sent, "Failed to sent Ether");
    }

    function sendViaCall(address payable _to) public payable {
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "Failed to sent Ether");
    }
}
