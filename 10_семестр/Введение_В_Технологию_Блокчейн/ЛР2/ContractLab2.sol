// SPDX-License-Identifier: MIT
pragma solidity >=0.7.12 <0.9.0;

contract Transportation
{
	string public name;
	address public owner;
	uint public cost;
	uint public weight;
	string public description;

	constructor()
	{
		name = "none";
		owner = msg.sender;
		cost = 0;
		weight = 0;
		description = "no info";
	}

	function addShip(string memory _name, uint _cost, uint _weight, string memory _descr) public returns (bool success)
	{
		name = _name;
		owner = msg.sender;
		cost = _cost;
		weight = _weight;
		description = _descr;
		return true;
	}

	function getInfo() public view returns (string memory, address, uint, uint, string memory)
	{
		return (name, owner, cost, weight, description);
	}
}
