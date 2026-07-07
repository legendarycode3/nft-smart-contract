// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18; 


import {Script} from "forge-std/Script.sol";
import {BasicNft} from  "../src/BasicNft.sol";

contract DeployBasicNft is Script {

    /**
     * @notice Executes the deployment logic.
     * @return The instance of the newly deployed BasicNft contract.
    */
    function run() external returns(BasicNft) {

        // vm.startBroadcast() records transactions to be sent to the RPC endpoint
        vm.startBroadcast();

        // Initialize and deploy the contract onto the network
        BasicNft basicNft = new BasicNft();

        // Finalize transaction recording
        vm.stopBroadcast();

        return basicNft;
    }
}