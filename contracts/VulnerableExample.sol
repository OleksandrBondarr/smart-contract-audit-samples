// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VulnerableExample {

    address public owner;
    uint256 public feePercent;

    constructor() {
        owner = msg.sender;
        feePercent = 5;
    }

    // ❌ Missing access control
    function setFeePercent(uint256 _newFee) external {
        feePercent = _newFee;
    }

    // ❌ No input validation
    function calculateFee(uint256 amount) external view returns (uint256) {
        return (amount * feePercent) / 100;
    }

    function withdraw() external {
        require(msg.sender == owner, "Not owner");
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {}
}
