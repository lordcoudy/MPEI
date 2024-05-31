pragma solidity >=0.5.0;

contract SendMoneyExample
{
    uint public balanceReceived;
    function receiveMoney() public payable 
    {
        balanceReceived +=msg.value;
    }
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function withdrawMoney() public 
    {
        address payable to = payable(msg.sender);
        
        to.transfer(this.getBalance());
    }
    function withdrawMoneyTo(address payable tpAddress) public
    {
        tpAddress.transfer(this.getBalance());
    }
}