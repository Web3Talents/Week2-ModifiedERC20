// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;

import "./modERC20.sol";

contract ModToken is modERC20 {
    //custom errors used for Input Validation and Access Control
    error InvalidInput();
    error MaxWillExceed();
    error Forbidden();


    mapping (address => bool) private isWhitelisted;
    constructor() modERC20("", "MOB"){
        _mint(msg.sender, 50000000000 * 10 **18);
    }

    function mintMoreTokens(uint amount) external {
        //ensure only whitelisted addresses can mint
        if(!isWhitelisted[msg.sender]) revert Forbidden();
       //maximum to be minted is 70,000,000,000 tokens.
       // ERC20 tokens are 18 decimals by default (Like Ethereum)  
       // So 1 token = 1 * 10**18
        uint maxToBeMinted= 70000000000 *10**18;
        //
        uint newMaxSupply = totalSupply() + amount;
        if(amount==0 ) revert InvalidInput();
        if(newMaxSupply > maxToBeMinted) revert MaxWillExceed();
        _mint(msg.sender, amount);
    }
    
}

