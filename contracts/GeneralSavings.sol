// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

contract GeneralSavings {
    address savingToken;
    address owner; 

    mapping (address => uint) etherSavings; 
    mapping (address => uint) tokenSavings;

    constructor(address _savingToken)  {
        savingToken = _savingToken;
        owner = msg.sender;
    }

    function depositEther(uint _etherAmount ) payable external{
        require(msg.sender != address(0), "address zero detected");
        
    }

    function depositToken(uint _savingsTokenAmount) view external{
        require(msg.sender != address(0), "address zero detected");
    }

    function withdrawEther( uint _etherAmount ) external{
        
    }

    function withdrawToken( uint _savingsTokenAmount ) external{
        
    }

    function checkSaverEtherBalance(address _saver) external view returns (uint) {
             

    }

     function checkSaverTokenBalance(address _saver) external view returns (uint) {
                 

    }

    function checkContractEtherBalance() external view  returns (uint) {
        
    }

    function checkContractTokenBalance() external view  returns (uint) {
        
    }
}