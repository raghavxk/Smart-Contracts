// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "./simpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public SimpleStorageArray;

    // creates new SimpleStorageContract and return it's address
    function createSimpleStorageContract() public returns (address) {
        SimpleStorage newSimpleStorageContract = new SimpleStorage();
        SimpleStorageArray.push(newSimpleStorageContract);
        return address(newSimpleStorageContract);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber)
        public
    {
        require(
            _simpleStorageIndex <= SimpleStorageArray.length,
            "index out of bound"
        );
        SimpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    function sfRetrieve(uint256 _simpleStorageIndex)
        public
        view
        returns (uint256)
    {
        require(
            _simpleStorageIndex <= SimpleStorageArray.length,
            "index out of bound"
        );
        return SimpleStorageArray[_simpleStorageIndex].retrieve();
    }
}
