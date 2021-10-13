// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface ICOZ {
    function mint(uint256[] memory parents, string memory code) payable external returns (uint256 id);
}
