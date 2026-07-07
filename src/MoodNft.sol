// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18; 

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";


/**
     * @title MoodNft
     * @author LegendaryCode
     * @notice A contract that allows users to mint dynamic NFTs that change their artwork 
     *         based on a toggleable mood.
     * @dev Inherits OpenZeppelin's ERC721 standard implementation. Uses Base64 encoding for 
     *      on-chain metadata.
 */
contract MoodNft is ERC721 {
    
                        /** TYPE DECLARATION */
    /// @notice Represents the possible visual and psychological states of the NFT.
    enum Mood {
        HAPPY,
        SAD
    }

    
    
                        /** STATE VARIABLES */
    /// @notice Incremental counter used to assign unique IDs to each minted NFT
    uint256 private s_tokenCounter;
    
    /// @notice Base64 encoded data URI strings containing the SVG source code for both moods
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;

    /// @notice  Maps each specific tokenId to its current active Mood state
    mapping(uint256 => Mood) private s_tokenIdToMood; 



                        /** ERRORS */
    /// @notice Reverted when an address tries to flip an NFT's mood without being the owner or approved operator.
    error MoodNft__CantFlipMoodIfNotOwner();
    


                        /** CONSTRUCTOR */
    /**
     * @notice Initializes the collection name, symbol, and pre-baked asset URIs.
     * @param sadSvgImageUri The base64 encoded SVG string representing the sad mood.
     * @param happySvgImageUri The base64 encoded SVG string representing the happy mood.
    */
    constructor(string memory sadSvgImageUri, string memory happySvgImageUri) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        
        s_sadSvgImageUri = sadSvgImageUri;
        s_happySvgImageUri = happySvgImageUri;
    }



                        /** EXTERNAL FUNCTIONS */
    /**
     * @notice Mints a new Mood NFT to the caller's wallet address.
     * @dev Automatically sets the initial state of the minted NFT to HAPPY and increments 
     *      the global counter.
    */
    function mintNft() public {
        // Securely mints the token to the message sender using the current counter value
        _safeMint(msg.sender, s_tokenCounter);

        // Sets the baseline mood of the newly minted token to HAPPY
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;

        // Increments the counter so the next minter receives a unique higher ID
        s_tokenCounter++;
    }



    /**
     * @notice Flips the current visual mood state of a specific token from Happy to Sad, or 
     *         vice versa.
     * @dev Access control checks if the msg.sender is either the direct owner or holds an 
     *      approved spending status.
     * @param tokenId The identifier of the specific NFT whose state is being updated.
    */
    function flipmood(uint256 tokenId) public  {
        // Require that the sender is explicitly approved or owns the token before allowing changes
        if (getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender) {
            revert MoodNft__CantFlipMoodIfNotOwner();
        }

        // Toggles the state variable cleanly based on its current position
        if(s_tokenIdToMood[tokenId] == Mood.HAPPY){
            s_tokenIdToMood[tokenId] = Mood.SAD;
        }else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    } 


        
                        /** INTERNAL FUNCTIONS */
    /**
     * @dev Overrides OpenZeppelin's standard hook to prepend the base standard formatting 
     *      for data URIs.
     * @return A hardcoded string representing a base64 JSON header payload.
    */
    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }



                        /** VIEW  FUNCTIONS */
    /**
     * @notice Generates and fetches the absolute on-chain JSON metadata URI for a targeted 
     *          token.
     * @dev Compiles dynamic JSON text, converts it to base64 format using OpenZeppelin 
     *      helpers, and returns the asset string.
     * @param tokenId The target token identifier being queried.
     * @return A fully structured base64 data URI holding token details and responsive SVG 
     *         image properties.
    */
    function tokenURI(uint256 tokenId) public view override returns (string memory) {

        string memory imageURI;

        // Checks current state mapping to pull the accurate asset string
        if(s_tokenIdToMood[tokenId] == Mood.HAPPY) {
                imageURI = s_happySvgImageUri;
        }else {
                imageURI = s_sadSvgImageUri;
        }

        // Dynamic construction using Base64.encode takes place below (Ensure implementation completes here)
        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes( 
                        abi.encodePacked(
                            '{"name": "', name(), '", ',
                            '"description": "An NFT that reflects the owners mood.", ',
                            '"attributes": [{"trait_type": "moodiness", "value": 100}], ',
                            '"image": "', imageURI, '"}'
                        )
                    )
                )
            )
        );

    }
}







