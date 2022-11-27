// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import 'hardhat/console.sol';
import './Main.sol';

contract Player {
    function register(address _main, address _ship1, address _ship2) external {
        Main(_main).register(_ship1);
        Main(_main).register(_ship2);
    }
}