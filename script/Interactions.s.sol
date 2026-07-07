// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {MoodNft} from "../src/MoodNft.sol";



/**
 * @title MintBasicNft
 * @notice A Foundry script to automate minting a basic NFT on the most recently deployed 
 *         contract.
 * @dev Inherits from Forge's Script contract and utilizes DevOpsTools for deployment 
 *      tracking.
*/
contract MintBasicNft is Script {
    // IPFS URI pointing to the metadata JSON for the Pug NFT
    string  public constant PUG =   "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json"; 

   
    /**
     * @notice Entry point for the script execution when running `forge script`.
     * @dev Fetches the active chain's latest deployment of BasicNft and triggers the mint 
     *      function.
    */
    function run() public {
        // Query the local broadcast logs to find the address of the latest BasicNft deployment
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);

        // Execute the minting interaction
        mintNftOnContract(mostRecentlyDeployed);
    }


    /**
     * @notice Interacts with the deployed BasicNft contract to mint a new token.
     * @dev Wraps the external contract call inside a broadcast block to sign and submit the 
     *      transaction.
     * @param contractAddress The address of the target BasicNft deployment.
    */
    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(PUG);
        vm.stopBroadcast();
    }

}




/**
 * @title MintMoodNft
 * @notice A Foundry script to automate minting a dynamic Mood NFT.
 * @dev Useful for automated testing environments or local deployment verification.
*/
contract MintMoodNft is Script {

    /**
     * @notice Entry point for running the Mood NFT mint script.
     * @dev Automatically identifies the latest deployment address using active chain ID.
    */
    function run() external {
        // Look up the last known deployment address for MoodNft
        address mostRecentlyDeployedMoodNft = DevOpsTools.get_most_recent_deployment("MoodNft", block.chainid);

         // Execute the minting process
        mintNftOnContract(mostRecentlyDeployedMoodNft);
    }


    /**
     * @notice Mints a Mood NFT on the specified target contract.
     * @dev Initiates an on-chain broadcast transaction to invoke the target contract's 
     *      intNft function.
     * @param moodNftAddress The address of the deployed MoodNft contract.
    */
    function mintNftOnContract(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).mintNft();
        vm.stopBroadcast();
    }
}



/**
 * @title FlipMoodNft
 * @notice A Foundry script to programmatically toggle the state/mood of a specific Mood NFT.
 * @dev This script assumes the target token ID has already been minted.
*/
contract FlipMoodNft is Script {
    // The specific NFT token identifier targeted for the state change
    uint256 public constant TOKEN_ID_TO_FLIP = 0;

    /**
     * @notice Entry point for running the Mood flipping script.
     * @dev Automatically finds the deployment target and invokes the state modification.
    */
    function run() external {
        // Fetch the active deployment address for MoodNft on the current network
        address mostRecentlyDeployedMoodNft = DevOpsTools.get_most_recent_deployment("MoodNft", block.chainid);

        // Execute the flipping action
        flipMoodNft(mostRecentlyDeployedMoodNft);
    }


    /**
     * @notice Calls the target contract to change the mood state of TOKEN_ID_TO_FLIP.
     * @dev Broadcasts an external call to the `flipmood` function on the target contract 
     *      address.
     * @param moodNftAddress The address of the deployed MoodNft contract.
    */
    function flipMoodNft(address moodNftAddress) public {
        vm.startBroadcast();
        MoodNft(moodNftAddress).flipmood(TOKEN_ID_TO_FLIP);
        vm.stopBroadcast();
    }
}