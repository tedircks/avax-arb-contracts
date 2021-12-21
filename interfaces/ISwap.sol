// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISwap {
    function swap(
        uint256 amount0Out,
        uint256 amount1Out,
        address to,
        bytes calldata data
    ) external;
}
