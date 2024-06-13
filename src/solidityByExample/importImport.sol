// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./imprtFoo.sol";

import {Unauthorized, add as func, Point} from "./imprtFoo.sol";

contract Import {
    Foo public foo = new Foo();

    function getFooName() public view returns (string memory) {
        return foo.name();
    }
}
