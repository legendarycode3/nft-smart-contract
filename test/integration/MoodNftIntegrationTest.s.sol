// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18; 

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "../../src/MoodNft.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";



/**
 * @title Mood NFT Test Suite
 * @author LegendaryCode
 * @notice This contract tests the minting, metadata generation, and mood-flipping logic of 
 *         MoodNft
 * @dev Inherits from Forge Standard Test library to utilize cheatcodes and assertions
 */
contract MoodNftTest is  Test {
    
    MoodNft moodNft;

    /// @notice The URI for the happy SVG image encoded in base64
    string public constant HAPPY_SVG_IMAGE_URI = "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjAwIDIwMCIgd2lkdGg9IjQwMCIgIGhlaWdodD0iNDAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPg0KICAgIDxjaXJjbGUgY3g9IjEwMCIgY3k9IjEwMCIgZmlsbD0ieWVsbG93IiByPSI3OCIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSIzIi8+DQogIDxnIGNsYXNzPSJleWVzIj4NCiAgICA8Y2lyY2xlIGN4PSI3MCIgY3k9IjgyIiByPSIxMiIvPg0KICAgIDxjaXJjbGUgY3g9IjEyNyIgY3k9IjgyIiByPSIxMiIvPg0KICA8L2c+DQogIDxwYXRoIGQ9Im0xMzYuODEgMTE2LjUzYy42OSAyNi4xNy02NC4xMSA0Mi04MS41Mi0uNzMiIHN0eWxlPSJmaWxsOm5vbmU7IHN0cm9rZTogYmxhY2s7IHN0cm9rZS13aWR0aDogMzsiLz4NCjwvc3ZnPg==";

    /// @notice The URI for the sad SVG image encoded in base64
    string public constant SAD_SVG_IMAGE_URI = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAyNHB4IiBoZWlnaHQ9IjEwMjRweCIgdmlld0JveD0iMCAwIDEwMjQgMTAyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4NCiAgPHBhdGggZmlsbD0iIzMzMyIgZD0iTTUxMiA2NEMyNjQuNiA2NCA2NCAyNjQuNiA2NCA1MTJzMjAwLjYgNDQ4IDQ0OCA0NDggNDQ4LTIwMC42IDQ0OC00NDhTNzU5LjQgNjQgNTEyIDY0em0wIDgyMGMtMjA1LjQgMC0zNzItMTY2LjYtMzcyLTM3MnMxNjYuNi0zNzIgMzcyLTM3MiAzNzIgMTY2LjYgMzcyIDM3Mi0xNjYuNiAzNzItMzcyIDM3MnoiLz4NCiAgPHBhdGggZmlsbD0iI0U2RTZFNiIgZD0iTTUxMiAxNDBjLTIwNS40IDAtMzcyIDE2Ni42LTM3MiAzNzJzMTY2LjYgMzcyIDM3MiAzNzIgMzcyLTE2Ni42IDM3Mi0zNzItMTY2LjYtMzcyLTM3Mi0zNzJ6TTI4OCA0MjFhNDguMDEgNDguMDEgMCAwIDEgOTYgMCA0OC4wMSA0OC4wMSAwIDAgMS05NiAwem0zNzYgMjcyaC00OC4xYy00LjIgMC03LjgtMy4yLTguMS03LjRDNjA0IDYzNi4xIDU2Mi41IDU5NyA1MTIgNTk3cy05Mi4xIDM5LjEtOTUuOCA4OC42Yy0uMyA0LjItMy45IDcuNC04LjEgNy40SDM2MGE4IDggMCAwIDEtOC04LjRjNC40LTg0LjMgNzQuNS0xNTEuNiAxNjAtMTUxLjZzMTU1LjYgNjcuMyAxNjAgMTUxLjZhOCA4IDAgMCAxLTggOC40em0yNC0yMjRhNDguMDEgNDguMDEgMCAwIDEgMC05NiA0OC4wMSA0OC4wMSAwIDAgMSAwIDk2eiIvPg0KICA8cGF0aCBmaWxsPSIjMzMzIiBkPSJNMjg4IDQyMWE0OCA0OCAwIDEgMCA5NiAwIDQ4IDQ4IDAgMSAwLTk2IDB6bTIyNCAxMTJjLTg1LjUgMC0xNTUuNiA2Ny4zLTE2MCAxNTEuNmE4IDggMCAwIDAgOCA4LjRoNDguMWM0LjIgMCA3LjgtMy4yIDguMS03LjQgMy43LTQ5LjUgNDUuMy04OC42IDk1LjgtODguNnM5MiAzOS4xIDk1LjggODguNmMuMyA0LjIgMy45IDcuNCA4LjEgNy40SDY2NGE4IDggMCAwIDAgOC04LjRDNjY3LjYgNjAwLjMgNTk3LjUgNTMzIDUxMiA1MzN6bTEyOC0xMTJhNDggNDggMCAxIDAgOTYgMCA0OCA0OCAwIDEgMC05NiAweiIvPg0KPC9zdmc+";


    DeployMoodNft deployer;

    address public USER = makeAddr("user");

    /**
     * @notice Sets up the testing environment before each test case runs
     * @dev Deploys a new instance of MoodNft using the deployment script
     */
    function setUp() public {
        deployer  = new DeployMoodNft();
        moodNft = deployer.run();
    }


    /**
     * @notice Verifies that tokenURI can be retrieved successfully after minting
     * @dev Mints a token as USER and logs the output URI to the console
    */
    function testViewTokenURIIntegration() public {
        // Arrange & Act: Impersonate USER and mint the first NFT (Token ID: 0)
        vm.prank(USER);
        moodNft.mintNft();
        
        // Assert: Log the generated JSON metadata URI for manual verification
        console.log(moodNft.tokenURI(0));
    }



    /**
     * @notice Verifies that flipping the mood correctly updates the Base64 JSON metadata
     * @dev Encodes the expected JSON string manually to strictly assert against the 
     *      contract output
     */
    function testFlipTokenToSad() public {
        // Arrange: Mint the initial NFT as USER
        vm.prank(USER);
        moodNft.mintNft();

        // Act: Flip the mood state of Token ID 0 from Happy to Sad
        vm.prank(USER);
        moodNft.flipmood(0);

        // Act: Reconstruct the expected Base64 data URI manually
        string memory expectedTokenUri = string(
        abi.encodePacked(
            "data:application/json;base64,",
            Base64.encode(
                bytes(
                    abi.encodePacked(
                        '{"name": "Mood NFT", ',
                        '"description": "An NFT that reflects the owners mood.", ',
                        '"attributes": [{"trait_type": "moodiness", "value": 100}], ',
                        '"image": "', SAD_SVG_IMAGE_URI, '"}'
                    )
                )
            )
            )
        );
       
       // Assert: Ensure the contract state updates match our expected cryptographic encoding
        assertEq(moodNft.tokenURI(0), expectedTokenUri);
        
    }


}


































