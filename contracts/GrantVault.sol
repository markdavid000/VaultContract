// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract GrantVault {
    struct Grant {
        address donor;
        address beneficiary;
        uint256 grantAmount;
        uint256 releaseTime;
        bool claimed;
    }

    mapping(address => Grant[]) grants;

    event GrantCreated(address indexed donor, address indexed beneficiary, uint256 grantAmount, uint256 releaseTime);
    event GrantClaimed(address indexed beneficiary, uint256 grantAmount);

    
}
