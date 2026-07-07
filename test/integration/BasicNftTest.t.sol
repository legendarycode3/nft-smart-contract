// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18; 

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";



/**
 * @title  Basic NFT Test Suite
 * @author LegendaryCode
 * @notice This contract tests the core functionalities of the BasicNft contract 
 *          using Foundry.
 * @dev Inherits from the Forge Standard Test library.
 */
contract BasicNftTest is  Test {

    /// @notice Instance of the NFT deployment script.
    DeployBasicNft  public deployer;

    /// @notice Instance of the target BasicNft contract being tested.
    BasicNft public basicNft;

    /// @notice Mock user address used to simulate external transactions.
    address public USER = makeAddr("user");

    /// @notice IPFS metadata URI used as a sample token URI for testing.
    string  public constant PUG =   "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json"; 

    
    /**
     * @notice Sets up the testing environment before each test case runs.
     *  @dev Initializes a new deployment script and deploys a fresh instance of BasicNft.
     */
    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = new BasicNft();
    }


    /**
     * @notice Verifies that the NFT contract initializes with the correct collection name.
     * @dev Compares string hashes since Solidity cannot natively compare strings using `==`.
     */
    function testNameIsCorrect() public {
        // ARRANGE: Set the expected collection name
        string memory expectedName = "Doggie";

        // ACT: Query the collection name from the deployed contract
        string memory actualName = basicNft.name();

        // ASSERT: Verify the names match by comparing their cryptographic hashes
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }


    /**
     *  @notice Verifies that users can successfully mint an NFT, incrementing their balance 
     *          and setting the correct token URI.
     * @dev Uses `vm.prank` to impersonate the mock user address during execution.
    */
    function testCanMintAndHaveABalance() public {
        // ARRANGE: Impersonate the mock user for the next external call
        vm.prank(USER);

        // ACT: Mint a new NFT with the sample PUG metadata URI
         basicNft.mintNft(PUG);

        // ASSERT: Verify the user owns exactly 1 NFT asset
        assert(basicNft.balanceOf(USER) == 1);

        // ASSERT: Verify the minted token (ID 0) points to the correct IPFS metadata hash
        assert(keccak256(abi.encodePacked(PUG)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));

    }



}