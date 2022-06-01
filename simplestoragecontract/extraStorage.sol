// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./simpleStorage.sol";

contract ExtraStorage is SimpleStorage {
    function store(uint256 _favouriteNumber) public override {
        favoriteNumber = _favouriteNumber + 1;
    }
}
