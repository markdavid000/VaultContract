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

    function offerGrant(address _beneficiary, uint256 _releaseTime) external payable {
        require(_beneficiary != address(0), "Beneficiary's address cannot be zero");
        require(msg.value > 0, "you can't grant zero value");
        require(_releaseTime > block.timestamp, "Release time is in the future");

        Grant memory newGrant = Grant({
            donor: msg.sender,
            beneficiary: _beneficiary,
            grantAmount: msg.value,
            releaseTime: _releaseTime,
            claimed: false
        });

        grants[_beneficiary].push(newGrant);

        emit GrantCreated(msg.sender, _beneficiary, msg.value, _releaseTime);
    }

    function claimGrant(uint _grantIndex) external {
        require(_grantIndex < grants[msg.sender].length, "Invalid grant Index");
        require(!grants[msg.sender][_grantIndex].claimed, "This grant has already been claimed");
        require(block.timestamp >= grants[msg.sender][_grantIndex].releaseTime, "Grant not yet available for claim");

        Grant memory grant = grants[msg.sender][_grantIndex];
        grant.claimed = true;
        payable(msg.sender).transfer(grant.grantAmount);

        emit GrantClaimed(msg.sender, grant.grantAmount);
    }
}
