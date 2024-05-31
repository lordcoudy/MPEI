// SPDX-License-Identifier: MIT
pragma solidity >=0.7.12 <0.9.0;

contract countSticksGame
{
	uint public stateOfGame;		//состояние игры (1-не начата, 2-идет, 3-закончена)
	uint public countSticks;		//кол-во палочек
	uint public countPlayers;		//кол-во зарегистрированных игроков
	address public currentPlayer;	//адрес ходящего игрока
	address public winner;			//адрес победителя

	mapping(uint => string) messages;

	address public owner;		//адрес владельца контракта
	address[2] public players;	//адреса игроков
	mapping(address => uint) playedcountSticks;   

	constructor()
	{
		owner = msg.sender;
		stateOfGame = 1;		//игра не начата
		countSticks = 10;		//все 10 палочек
		countPlayers = 0;		//нет зарегистрированных игроков

		messages[1] = "Game is not started";
		messages[2] = "Game continues";
		messages[3] = "Game is finished, winner: ";
	}

	modifier RegistrationAllowed()
	{
		require(stateOfGame == 1, "Registration closed!");		//если игра уже началась или закончилась, то регистрация закрыта
		require(countPlayers < 2, "Registration closed!");	//если уже зарегистрированы 2 игрока, то регистрация закрыта
		_;
	}

	modifier MakeTurnAllowed()
	{
		require(stateOfGame == 2, "Game is not started now!");					//если игра не начата, то ходить нельзя
		require(msg.sender == currentPlayer, "You are not a currentPlayer gamer!");		//если сейчас не ваш ход, то ходить нельзя
		_;
	}

	modifier ownerAllowed()
	{
		require(msg.sender == owner, "You are not an owner of contract!");	//проверка, являетесь ли вы владельцем контракта
		_;
	}

	function NewGame() public
	{
		stateOfGame = 1;		//игра не начата
		countSticks = 10;		//все 10 палочек
		countPlayers = 0;		//нет зарегистрированных игроков
	}

	function Registration() public RegistrationAllowed returns (string memory)
	{
		players[countPlayers] = msg.sender;
		playedcountSticks[msg.sender] = 0;	//кол-во сыгранных палочек = 0
		countPlayers++;
		if(countPlayers == 2)				//если набралось 2 игрока
		{
			stateOfGame = 2;				//то запускаается игра
			currentPlayer = players[0];		//а текущий игрок - нулевой
		}
		string memory message = "You are successfully registered";
		return message;
	}

	function MakeTurn(uint count) public MakeTurnAllowed returns (string memory)
	{
		playedcountSticks[msg.sender] += count;	//кол-во сыгранных палочек указывается игроком
		for(uint i = 0; i < 2; i++)
		{
			if(msg.sender != players[i]) { currentPlayer = players[i]; }
		}
		countSticks -= count;					//из текущего числа палочек отнимаем сыгранные
		if(countSticks > 0)
		{
			string memory message = "Next MakeTurn";
			return message;
		}
		else								//когда число палочек = 0
		{
			stateOfGame = 3;						//игра заканчивается
			winner = currentPlayer;				//победитель - текущий игрок
			string memory message = "Game over!";
			return message;
		}
	}

	function GetStateOfGame() public view ownerAllowed returns (string memory)
	{
		string memory message;
		if(stateOfGame != 3)
		{
			message = messages[stateOfGame];
		}
		else
		{
			string memory addr = ToAsciiString(winner);
			message = string.concat(messages[stateOfGame], addr);
		}
		return message;
	}

	function ToAsciiString(address x) internal pure returns (string memory)
	{
		bytes memory s = new bytes(40);
		for (uint i = 0; i < 20; i++)
		{
			bytes1 b = bytes1(uint8(uint(uint160(x)) / (2**(8*(19 - i)))));
			bytes1 hi = bytes1(uint8(b) / 16);
			bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
			s[2*i] = char(hi);
			s[2*i+1] = char(lo);
		}
		return string(s);
	}

	function char(bytes1 b) internal pure returns (bytes1 c)
	{
		if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
		else return bytes1(uint8(b) + 0x57);
	}

	function getPlayers() public view returns (string memory, string memory)
	{
		string memory player1 = ToAsciiString(players[0]);
		string memory player2 = ToAsciiString(players[1]);
		string memory message1 = string.concat("player1: ", player1);
		string memory message2 = string.concat("player2: ", player2);
		return (message1, message2);
	}
}