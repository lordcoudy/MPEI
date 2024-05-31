pragma solidity >=0.5.0;

contract addressTest {
    
   address public myAddress;
   address public creator;
   constructor (address initialAddress) public
   {
     myAddress = initialAddress;
     creator = msg.sender;

   }
   function getBalanceOfAddress() public view returns(uint)
    {
        return myAddress.balance;
    }

    function getBalanceOfContract() public view returns(uint)
    {
        return address(this).balance;
    }

    receive() external payable { 
    
    }
}