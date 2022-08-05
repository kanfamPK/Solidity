// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "./SimpleStorage.sol";

contract StorageFactory {

    SimpleStorage[] public _simpleStorageArray;
    function createSimpleStorage() public {
        SimpleStorage _simpleStorage = new SimpleStorage();
        _simpleStorageArray.push(_simpleStorage);
    }

    // sf stand for storage factory
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        _simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        return _simpleStorageArray[_simpleStorageIndex].retrieve();
    }

}