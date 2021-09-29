// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import the SimpleStorage contract from other file
import "./SimpleStorage.sol";

// Inherit SimpleStorage's properties / methods
// into StorageFactory
contract StorageFactory is SimpleStorage {
    // Initialize an empty array of SimpleStorage contracts
    SimpleStorage[] public simpleStorageArray;
    // Function to generate a new SimpleStorage contract
    // and adds it to the array
    function createSimpleStorageContract() public {
        SimpleStorage ss = new SimpleStorage();
        simpleStorageArray.push(ss);
    }
    // Function that stores a number into the favoriteNumber variable
    // of a SimpleStorage contract, by it's index in the array
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).store(_simpleStorageNumber);
    }
    // Function that returns the variable favoriteNumber variable
    // of a SimpleStorage contract, by it's index in the array
    function adGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        return SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieve();
    }
}