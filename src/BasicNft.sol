// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18; 

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";


/**
 * @title BasicNft
 * @author LegendaryCode
 * @notice This contract is a bare-bones implementation of an ERC-721 non-fungible token 
 *         (NFT).
 * @dev Implements OpenZeppelin's ERC721 standards to allow minting and tracking NFTs with 
 *      custom URIs.
*/
contract BasicNft is ERC721 {
    /// @notice Tracks the current token ID to be minted next.
    uint256 private s_tokenCounter;

    /// @notice Maps each token ID to its respective off-chain metadata URL.
    mapping(uint256 => string) private s_tokenIdToUrl;

    /**
     * @notice Initializes the NFT contract with a name and symbol.
     * @dev Calls the parent `ERC721` constructor with the name "Doggie" and the symbol 
     *      "DOG".
    */
    constructor() ERC721("Doggie", "DOG") {
        s_tokenCounter = 0;
    }


    /**
     * @notice Mints a new NFT and assigns it to the caller.
     * @dev Increments `s_tokenCounter` after minting to ensure unique IDs for each token.
     * @param tokenUrl The off-chain URI string pointing to the token's metadata.
    */
    function mintNft(string memory tokenUrl) public {

        // Store the metadata URL mapped to the current token ID
        s_tokenIdToUrl[s_tokenCounter] = tokenUrl;
            
        // Mint the token and transfer it to the address invoking the function
        _safeMint(msg.sender, s_tokenCounter);

        // Increment the counter for the next mint
        s_tokenCounter++;
    }


    /**
     * @notice Retrieves the metadata Uniform Resource Identifier (URI) for a given token ID.
     * @dev Overrides the standard `tokenURI` function to return the custom mapped URL.
     * @param tokenId The unique identifier of the NFT.
     * @return string memory The off-chain metadata URL.
    */
    function tokenURI(uint256 tokenId) public view override returns (string memory) {

        return s_tokenIdToUrl[tokenId];
    }
    

}