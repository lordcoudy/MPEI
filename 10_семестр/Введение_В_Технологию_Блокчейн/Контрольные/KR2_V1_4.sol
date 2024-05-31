// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract DonationService {
    
    struct transfer{
        address to;
        address from;
        uint256 amount;
    }
    transfer[] public history;

    address owner;

    constructor(){
        owner = msg.sender;
    }

    function donate() public payable{
        require(msg.value > 0, "Donation amount must be greater than 0");
        history.push(transfer(msg.sender,owner,msg.value));
    }

    function transferTo(address payable to, uint256 amount) public  {
        require(msg.sender==owner,"Owner use only");
        require(address(this).balance >= amount,"Insuffisient money");
        to.transfer(amount);
        history.push(transfer(owner,to,amount));
    }

    function checkBalance() public view returns (uint256) {
        require(msg.sender==owner,"Owner use only");
        return address(this).balance;
    }
}