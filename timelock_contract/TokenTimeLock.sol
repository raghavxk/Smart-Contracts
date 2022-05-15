pragma solidity ^0.8.12;

import "./Token.sol";

contract TokenTimeLock {
    Token public token;
    address public beneficiary;
    uint256 public releaseTime;

    constructor(
        Token _token,
        address _beneficiary,
        uint256 _releaseTime
    ) {
        require(_releaseTime > block.timestamp);
        token = _token;
        beneficiary = _beneficiary;
        releaseTime = _releaseTime;
    }

    function release() public {
        require(block.timestamp > releaseTime);
        uint256 amount = token.balanceOf(address(this));
        require(amount > 0);
        token.transfer(beneficiary, amount);
    }
}
