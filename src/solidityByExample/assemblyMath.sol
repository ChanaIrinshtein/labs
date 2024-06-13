// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract AssemblyMath {
    function yul_add(uint256 x, uint256 y) public pure returns (uint256 z) {
        assembly {
            z := add(x, y)
            if lt(z, x) { revert(0, 0) }
        }
    }

    function yul_mul(uint256 x, uint256 y) public pure returns (uint256 z) {
        assembly {
            switch x
            case 0 { z := 0 }
            default {
                z := mul(x, y)
                if iszero(eq(div(z, x), y)) { revert(0, 0) }
            }
        }
    }

    function yul_fixed_point_round(uint256 x, uint256 y) public pure returns (uint256 z) {
        assembly {
            let half := div(y, 2)
            z := add(x, half)
            z := mul(div(z, y), y)
        }
    }
}
