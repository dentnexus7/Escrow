pragma solidity ^0.5.1;

contract Escrow {
    address agent;
    mapping(address => uint256) public deposits;

    modifier onlyAgent() {
        require(msg.sender == agent);
        _;
    }
    
    constructor() public {
        agent = msg.sender;
    }

    function deposit(address _payee) public onlyAgent payable {
        uint256 amount = msg.value;
        deposits[_payee] = deposits[_payee] + amount; // Use SafeMath
    }

    function withdraw(address payable _payee) public onlyAgent {
        uint256 payment = deposits[_payee];
        deposits[_payee] = 0;
        _payee.transfer(payment);
    }
}