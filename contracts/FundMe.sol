// SPDX-License-Identifier: MIT
pragma solidity >=0.6.6 <0.9.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract FundMe {
    // Prevent overflow of integers
    using SafeMathChainlink for uint256;

    // Declare an object with key of address and value of integers
    // to keep track of all the transfers.
    mapping(address => uint256) public addressToAmountFunding;
    // Declare an array to store all funders
    address[] public funders;

    // Declare an owner address and initialize it with the contract creator address
    // with the use of a constructor
    address public owner;
    constructor() public {
        owner = msg.sender;
    }
    
    // Function to receive funds higher than 50 dollars, store the transanction in addressToAmountFunding
    // and push a new sender to the funders array
    function fund() public payable {
        uint256 minimumUSD = 50 * 10 ** 18;
        require(getConversionRate(msg.value) >= minimumUSD, "You need to spend more ETH!");
        addressToAmountFunding[msg.sender] += msg.value;
        funders.push(msg.sender);
    }
    
    // Function to get the latest ETH -> USD conversion
    function getPrice()
        public
        view
        returns (uint256) {
            (,int256 answer,,,) = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e).latestRoundData();
            
            return uint256(answer * 10000000000);
        }
        
    // Function to get an ETH amount turned to USD
    function getConversionRate(uint256 ethAmount)
        public
        view
        returns (uint256) {
            uint256 ethPrice = getPrice();
            uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1000000000000000000;
            return ethAmountInUSD;
        }
    
    // Modifier that assures us that the sender MUST be the owner of the contract
    modifier onlyOwner {
        require(msg.sender == owner, "You're not the owner of this contract");
        _;
    }
    
    // Function to withdraw all transfers back to the owner of the crypto crowdfunding,
    // Setting both the transfers and the funders back to {} and [], respectively
    function withdraw() payable onlyOwner public {
        msg.sender.transfer(address(this).balance); // address(this).balance is pointing at all ETH stored in the contract
        
        for (uint256 funderIdx = 0; funderIdx < funders.length; funderIdx++) {
            address funder = funders[funderIdx];
            addressToAmountFunding[funder] = 0;
        }
        
        funders = new address[](0);
    }
    
}