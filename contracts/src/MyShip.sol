// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "./Ship.sol";
import 'hardhat/console.sol';
import './Main.sol';
import "./MyShip2.sol";

contract MyShip is Ship {

    // Variables utilisées pour la génération aléatoire d'entiers
    address private rand;
    uint private cpt = 0;
    // Position du bateau
    uint private x;
    uint private y;
    // Taille du board
    uint private board_width;
    uint private board_height;
    // Position du bateau allié
    uint private fx;
    uint private fy;

    constructor(address _rand) {
        rand = _rand;
        x = 1;
        y = 1;
    }

    function random(uint _number) public returns(uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, rand, cpt++))) % _number;
    }

    function update(uint _x, uint _y) public virtual override {
        x = _x;
        y = _y;
    }

    function fire() public virtual override returns (uint, uint) {
        // Fonction initiale
        
        // uint a;
        // uint b;
        // bool invalid = true;
        // while(invalid) {
        //     a = random(board_width);
        //     b = random(board_height);
        //     if ((a != x || b != y) && (a != fx || b != fy)) invalid = false;
        // }
        // return (a, b);

        // Test: MyShip tire sur son allié (MyShip2)
        return (fx, fy);
    }

    function place(uint _width, uint _height) public virtual override returns (uint, uint) {
        board_width = _width;
        board_height = _height;
        x = random(_width);
        y = random(_height);
        return (x, y);
    }

    // Fonctions permettant de communiquer avec le bateau allié et récupérersa position 
    function getPos(address _ship) external {
        (uint a, uint b) = MyShip2(_ship).givePos();
        fx = a;
        fy = b;
    }

    function givePos() external view returns (uint, uint) {
        return (x, y);
    }
}