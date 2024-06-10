// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Error {
    function testRequire(uint _i) public pure {
        require( _i > 10, "input must be greater than 10");
    }

    function testRevert(uint _i) public pure {
        if(_i <= 10) {
            revert("input must be greater than 10");
        }
    }

    uint public num;

    function testAssert() public view {
        assert(num == 0);
    }

    error InsufficientBalance(uint balance, uint withdrawAmount);

    function testCustomError(uint _withdrawAmount) public view {
        uint bal = address(this).balance;
        if(bal < _withdrawAmount) {
            revert InsufficientBalance({
                balance: bal,
                withdrawAmount: _withdrawAmount
            });
        }
    }
}

