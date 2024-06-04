// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

//Transparent upgradeable proxy pattern

contract CounterV1 {
    uint256 public count;

    function inc() external{
        count +=1;

    }   delegate();
}

contract CounterV2 {
    uint256 public count;

    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }
}

contract BuggyProxy {
    address public implementation;
    address public admin;

    constractor() {
        admin = msg.sender;
    }

    function _delegate() private {
        (bool ok,) = implementation.delegatecall(msg.data);
        require(ok, "delegatecall failed");
    }

    fallback() external payable {
        _delegate();
    }

    receive() external payable {
        _delegate();
    }

    function upgradeTo(address _implementation) external {
        require(msg.sender == admin, "not authorized");
        implementation = _implementation;
    }
}

contract Dev {
    function selectors() external view returns (bytes4, bytes4, bytes4) {
        return(
            Proxy.admin.selector,
            Proxy.implementation.selector,
            Proxy.upgradeTo.selector
        );
    }
}

contract Proxy {
    bytes32 private constant IMPLEMENTATION_SOLT = 
        bytes32(uint256(keccak256("eip1967.proxy.implementation")) -1);
    bytes32 private constant ADMIN_SOLT=
        bytes32(uint256(keccak256("eip1967.proxy.admin")) -1);
}

    constructor() {
        setAdmin(msg.sender);
    }

    modifier ifAdmin() {
        if(msg.sender == _getAdmin()){
            _;
        } else {
            _fallback();
        }
    }

    

