// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "./Ship.sol";
import 'hardhat/console.sol';
import './Main.sol';

contract MyShip is Ship {

    address public shipId;
    uint private x;
    uint private y;
    uint private board_width;
    uint private board_height;

    constructor() {
        shipId = msg.sender;
        x = 1;
        y = 1;

    }

    function random(uint _number) public view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender))) % _number;
    }

    function update(uint _x, uint _y) public virtual override {
        x = _x;
        x = _y;
    }

    function fire() public virtual override returns (uint, uint) {
        // uint a;
        // uint b;
        // bool invalid = true;
        // while(invalid) {
        //     a = random(board_width);
        //     b = random(board_height);
        //     if (a != x) invalid = false;
        // }
        return (x, y);
    }

    function place(uint _width, uint _height) public virtual override returns (uint, uint) {
        board_width = _width;
        board_height = _height;
        x = random(_width);
        y = random(_height);
        return(x, y);
    }

    function register(address _main, address _ship) external {
        Main(_main).register(_ship);
    }
}