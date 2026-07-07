// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18; 

import {Test, console2} from "forge-std/Test.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";



/** @title Test contract for Mood NFT deployment and utility functions
 *  @notice This contract tests the SVG parsing and deployment logic of DeployMoodNft
 *  @dev Inherits from Forge Standard Test to utilize assertion and logging libraries
 */
contract DeployMoodNftTest is  Test {

    /// @notice Instance of the deployment script contract being tested
    DeployMoodNft public deployer;

    /**
     *  @notice Sets up the testing environment before each test case runs
     * @dev Initializes a new instance of the DeployMoodNft script
     */
    function setUp() public {
        deployer = new DeployMoodNft();

        
    }


    /**
     * @notice Validates that raw SVG strings are correctly converted to Base64 data URIs
     * @dev Compares the output of svgToImageURI against a pre-computed valid Base64 string
    */
    function testConvertSvgToUri() public view {

        // Pre-computed, expected Base64-encoded SVG data URI output
        string memory expectedUri = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj48dGV4dCB4PSIwIiB5PSIxNSIgZmlsbD0iI2YxZjFmMSI+SGkhIFlvdXIgYnJvd3NlciBkZWNvZGVkIHRoaXM8L3RleHQ+PC9zdmc+";

        // Raw input SVG string used as the test payload
        string memory svg =  '<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500"><text x="0" y="15" fill="#f1f1f1">Hi! Your browser decoded this</text></svg>';

        // Execute the function under test
        string memory actualUri  = deployer.svgToImageURI(svg);

        // Strings cannot be compared directly in Solidity; hash them using keccak256 first
        assert(
            keccak256(abi.encodePacked(actualUri)) == keccak256(abi.encodePacked(expectedUri))
        );
        
    }
}