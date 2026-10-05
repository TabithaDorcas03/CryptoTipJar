// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {CryptoTipJar} from "../src/CryptoTipJar.sol";

contract CryptoTipJarScript is Script {
    function run() external returns (CryptoTipJar) {
        vm.startBroadcast();

        CryptoTipJar tipJar = new CryptoTipJar();

        vm.stopBroadcast();

        return tipJar;
    }
} 