// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function balanceOf(address who) external view returns (uint256);
}

contract Vault {
    mapping(address => uint256) public balances;

    function deposit(address token, uint256 amount) external {
        require(IERC20(token).transferFrom(msg.sender, address(this), amount), "transferFrom failed");
        balances[msg.sender] += amount;
    }

    function withdraw(address token, uint256 amount) external {
        require(balances[msg.sender] >= amount, "insufficient");
        // Vulnerable pattern (external call before effects)
        require(IERC20(token).transfer(msg.sender, amount), "transfer failed");
        balances[msg.sender] -= amount;
    }

    // Intentionally vulnerable: no access control
    function sweep(address token, address to) external {
        uint256 bal = IERC20(token).balanceOf(address(this));
        require(IERC20(token).transfer(to, bal), "transfer failed");
    }
}
