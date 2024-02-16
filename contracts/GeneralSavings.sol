// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;
import "./ISavingsToken.sol";

contract GeneralSavings {
    address savingToken;
    address owner; 

    mapping (address => uint) etherSavings; 
    mapping (address => uint) tokenSavings;

    constructor(address _savingToken)  {
        savingToken = _savingToken;
        owner = msg.sender;
    }

        event SavingSuccessful(address indexed user, uint256 indexed amount);
    event WithdrawSuccessful(address receiver, uint256 amount);


    function depositEther(uint _etherAmount ) payable external{
        require(msg.sender != address(0), "address zero detected");
        require(_etherAmount > 0, "Can't save 0 ethers");
        etherSavings[msg.sender] = etherSavings[msg.sender] + msg.value;
        emit SavingSuccessful(msg.sender, msg.value);
    }

    function depositToken(uint _savingsTokenAmount) external{
        require(msg.sender != address(0), "address zero detected");
        require(_savingsTokenAmount > 0, "Can't save 0 Token") ;
        require(ISavingsToken(savingToken).balanceOf(msg.sender) >= _savingsTokenAmount, "not enough tokens");
        require(ISavingsToken(savingToken).transferFrom(msg.sender, address(this), _savingsTokenAmount), "failed to transfer");

        tokenSavings[msg.sender] = tokenSavings[msg.sender] + _savingsTokenAmount;

        emit SavingSuccessful(msg.sender, _savingsTokenAmount);

    }

    function withdrawEther( uint _etherAmountToBeWithdrawn ) external{
         require(msg.sender != address(0), "address zero detected");

        uint256 _userExistingSavings = etherSavings[msg.sender];

        require(_userExistingSavings > 0, "you don't have any savings");

        require(_userExistingSavings > _etherAmountToBeWithdrawn, "you don't up the amount inputed");

        _userExistingSavings = _userExistingSavings - _etherAmountToBeWithdrawn;

        payable(msg.sender).transfer(_etherAmountToBeWithdrawn);
    }

    function withdrawToken( uint _savingsTokenAmount ) external{
         require(msg.sender != address(0), "address zero detected");
        require(_savingsTokenAmount > 0, "can't withdraw zero value");

        uint256 _userSaving = tokenSavings[msg.sender];

        require(_userSaving >= _savingsTokenAmount, "insufficient funds");

        tokenSavings[msg.sender] -= _savingsTokenAmount;

        require(ISavingsToken(savingToken).transfer(msg.sender, _savingsTokenAmount), "failed to withdraw");

        emit WithdrawSuccessful(msg.sender, _savingsTokenAmount);
    }

    function checkSaverEtherBalance(address _saver) external view returns (uint) {
          return  etherSavings[_saver];

    }

     function checkSaverTokenBalance(address _saver) external view returns (uint) {
        return tokenSavings[_saver];


    }

    function checkContractEtherBalance() external view  returns (uint) {
        return address(this).balance;
    }

    function checkContractTokenBalance() external view  returns (uint) {
                return ISavingsToken(savingToken).balanceOf(address(this));

    }
}