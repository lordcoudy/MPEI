pragma solidity >=0.5.0;

contract StringTest1 
{
   string public message;

    constructor (string memory initialMessage) public
    {
        message = initialMessage;       
    }

    function setMessage(string memory initialMessage) public
    {
      string memory newString = new string(3); 
      bytes memory fromBytes = bytes(newString);
      for (uint i = 0; i < fromBytes.length; i++) {
           fromBytes[i] = 'A';
      }
      string memory destination = string(fromBytes);
      message = destination;

    }

    function compare2(string memory str1, string memory str2) public pure returns (bool) {
        if (bytes(str1).length != bytes(str2).length) {
            return false;
        }
        return keccak256(abi.encodePacked(str1)) == keccak256(abi.encodePacked(str2));
    }

    function getMessage() public view returns (string memory)
   {
      if (compare2(message, "AAA"))
        return "Skazal Privet";
      else
        return message;
   }



}