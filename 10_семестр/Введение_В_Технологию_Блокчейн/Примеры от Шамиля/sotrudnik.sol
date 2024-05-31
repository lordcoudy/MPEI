// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0;

import "@openzeppelin/contracts/utils/Strings.sol";
contract sotrudnik{
string public familia;
uint public age;
uint public zarplata;
string public pol;
constructor (string memory fam, uint age1,
uint zar, string memory pol1) public{
familia=fam;
age=age1;
zarplata=zar;
pol=pol1;
}
function getInform () public view returns (string memory)
{
return string (abi.encodePacked(' familia: ', familia,
' age:',Strings.toString(age), ' zarplata:',
Strings.toString(zarplata)));
}
function setzarplata (uint newzarplata) public
{
zarplata=newzarplata;
}
}