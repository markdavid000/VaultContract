//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IGrantVault {
    struct Grant {
        address donor;
        address beneficiary;
        uint256 grantAmount;
        uint256 releaseTime;
        bool claimed;
    }
    function offerGrant(address _beneficiary, uint256 _releaseTime) external payable;
    function claimGrant(uint _grantIndex) external;
    function getGrant(address _beneficiary) external view returns(Grant[] memory);
    function getGrantCount(address _beneficiary) external view returns(uint256);
}