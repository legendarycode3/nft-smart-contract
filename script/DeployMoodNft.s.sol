// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18; 


import {Script, console} from "forge-std/Script.sol";
import {MoodNft} from  "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";



/**
 * @title  Deployment Script for MoodNft
 * @author LegendaryCode
 * @notice Reads SVG files from disk, converts them to data URIs, and deploys the MoodNft 
 *         contract.
 * @dev Uses Foundry's forge-std Script for deployment automation and OpenZeppelin's Base64 
 *      for encoding.
 */
contract DeployMoodNft is Script {
    /**
     *  @notice Execution entry point for the Foundry deployment script.
     *  @dev Reads SVG files using cheatcodes and passes encoded URIs to the constructor.
     *  @return The deployed instance of the MoodNft contract.
    */
    function run() external returns(MoodNft) {
        // Read raw SVG source text from the local file system
        string memory sadSvg = vm.readFile("./images/sad.svg");
        string memory happySvg = vm.readFile("./images/happy.svg"); 

        // Directs Foundry to sign transactions using the deployer's private key
        vm.startBroadcast();

        // Instantiate contract on-chain with base64 encoded image strings
        MoodNft moodNft = new MoodNft(
            svgToImageURI(sadSvg),
            svgToImageURI(happySvg)
        );

        // Terminate transaction broadcasting
        vm.stopBroadcast();

        return moodNft;
    }


    /**
     * @notice Converts raw SVG text into a valid, browser-readable Base64 Data URI.
     * @dev Uses abi.encodePacked to convert the string to bytes before OpenZeppelin 
     *      encoding. 
     * @param svg The raw string content of the SVG file.
     * @return The complete data URI string including the media type prefix.
    */
    function svgToImageURI(string memory svg) public pure returns(string memory) {
         // Standard data URL prefix required by browsers for inline SVG rendering
        string memory baseURL = "data:image/svg+xml;base64,"; 

        // Convert the string to bytes, pack it efficiently, and encode to base64
         string  memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );

        // Concatenate prefix and base64 payload into the final URI string
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}