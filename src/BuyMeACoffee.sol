// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract BuyMeACoffee{

    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string message,
        string name
    );

    struct Memo{
        address from;
        uint256 timestamp;
        string message;
        string name;
    }

    Memo[] memos;

    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner {
        require(msg.sender == owner, "must be owner to access");
        _;
    }

    function buyCoffee(string memory _message, string memory _name) public payable {
        //emit NewMemo(msg.sender, block.timestamp, message, name);
        require(msg.value > 0, "cannot buy coffee with 0 ETH");

        memos.push(
            Memo(    
                msg.sender,
                block.timestamp,
                _message,
                _name
            )
        );

        emit NewMemo(
            msg.sender,
            block.timestamp,
            _message,
            _name
        );
    }

    function getMemos() public view returns (Memo[] memory) {
        return memos;
    }

    function collectTips() public onlyOwner{
        require(owner.send(address(this).balance));
    }
}