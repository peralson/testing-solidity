// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    // Generate a favoriteNumber variable, initialized to 0
    uint256 favoriteNumber;
    // Define the structure of a Person
    struct Person {
        uint256 favoriteNumber;
        string name;
    }
    // Declare an empty array of Person in a variable called people
    Person[] public people;
    // Mapping function to retrieve favoriteNumber from name
    mapping(string => uint256) public nameToFavoriteNumber;
    // Function that store a new value in "General" favoriteNumber
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }
    // Function that returns that "General" favoriteNumber
    function retrieve() public view returns (uint256){
        return favoriteNumber;
    }
    // Function to add a Person to the array of people
    // and make him "mappable" by his/her name
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(
            Person({
                favoriteNumber: _favoriteNumber,
                name: _name
            })
        );
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
    
}