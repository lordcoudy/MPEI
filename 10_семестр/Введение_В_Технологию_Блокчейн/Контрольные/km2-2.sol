// SPDX-License-Identifier: MIT
pragma solidity >= 0.5.0;

// Разработать смарт-контракт на Ethereum для децентрализованного благотворительного фонда. 
// Смарт-контракт должен позволять пользователям отправлять ETH на контракт в качестве пожертвований. 
// Владелец контракта (администратор фонда) может перевести собранные средства на указанные благотворительные организации (адреса). 
// Дополнительно, контракт должен предоставлять информацию о суммарных пожертвованиях и перечне организаций-получателей.
// Требования к функционалу:
// Функция пожертвования: 
// Позволяет любому пользователю отправить ETH на контракт. 
// При отправке средств пользователь может указать, в честь какого события или цели он делает пожертвование.
// Функция перевода средств: 
// Владелец контракта может перевести накопленные средства на другой счет (адрес организации). 
// Данная функция должна быть защищена модификатором, ограничивающим вызов только владельцем.
// Отчетность: 
// Контракт должен вести историю пожертвований и переводов, позволяя просматривать общее количество пожертвований и список получателей.

contract GoodDeeds
{
    address payable owner;
    struct Tranfers
    {
        address _from;
        address _to;
        uint amount;
    }

    Tranfers[] public trasfersHistory;

    constructor()
    {
        owner = payable (msg.sender);
    }

    function donate () payable public 
    {
        require(msg.value > 0, "NO MONEY. U POOR");
        owner.transfer(msg.value);
        trasfersHistory.push(Tranfers(msg.sender, owner, msg.value));
    }

    function sendFunds (address payable fund) payable public
    {
        require(msg.sender == owner, "Only owner");
        require(msg.value > 0, "DON'T BE GREEDY");
        fund.transfer(msg.value);
        trasfersHistory.push(Tranfers(owner, fund, msg.value));
    }
}