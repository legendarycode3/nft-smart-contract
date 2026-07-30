# NFT Smart Contracts


## Project Overview
This repository contains two ERC-721 Non-Fungible Token (NFT) smart contracts built with `Solidity`, `OpenZeppelin`, and the `Foundry` development framework. The project showcases both traditional and dynamic NFT implementations while demonstrating best practices for NFT development, deployment, testing, and interaction. </br>
The repository includes two NFT collections:
* **Basic NFT**: A standard ERC-721 implementation that allows users to mint NFTs using off-chain metadata stored on IPFS.
* **Mood NFT**: A dynamic ERC-721 implementation that generates metadata entirely on-chain. The NFT artwork changes between `Happy` and `Sad` states, with both SVG images and metadata encoded using `Base64 Data URIs`. </br>
In addition to the smart contracts, the project provides deployment scripts, interaction scripts, unit tests, and integration tests, offering a complete end-to-end example of building, deploying, testing, and interacting with ERC-721 NFTs using Foundry.



## 📌 Features

### Overall Features
* Demonstrates both traditional and dynamic NFT architectures.
*  Two ERC-721 NFT implementations.
*  Built with Solidity,  Foundry, and OpenZeppelin Contracts.
*  Automated deployment using Foundry scripts. 
*  Smart contract interaction scripts for minting and state updates.
*  Comprehensive unit and integration test suites.
*  IPFS-based metadata support.
*  Fully on-chain metadata generation.
*  Dynamic SVG artwork rendering.
*  Base64 encoding for metadata and images.
*  Standards-compliant ERC-721 implementation.

### Basic NFT Features
* ERC-721 compliant NFT.
* Mint NFTs with custom metadata URIs.
* Supports IPFS-hosted metadata.
* Sequential token ID generation.
* Safe NFT minting using `_safeMint`.
* Custom `tokenURI()` implementation.
* Ownership tracking through  the ERC-721 standard.
* Lightweight and gas-efficient architecture.

### Mood NFT Features
* ERC-721 compliant NFT.
* Fully on-chain metadata generation.
* Fully on-chain SVG artwork.
* Base64-encoded JSON metadata.
* Base64-encoded SVG images.
* Dynamic NFT state management.
* Mood switching (Happy ↔ Sad).
* Dynamic artwork updates through `tokenURI()`.
* Data URI metadata support.
* Initial mood set to **HAPPY** upon minting.
* Owner or approved operator authorization for mood changes.
* Custom Solidity errors for gas-efficient access control.
* Enum-based mood state management.


## Smart Contracts
This repository contains  two ERC-721 smart contracts that demonstrate different approaches to NFT development. While both contracts are built on OpenZeppelin's ERC721 implementation and adhere to the ERC-721 standard, they differ significantly in how metadata is stored,  generated, and managed. </br>
The **Basic NFT** contract represents a traditional NFT architecture where metadata is stored off-chain using IPFS, whereas the **Mood NFT** contract demonstrates a modern dynamic NFT design that generates its metadata entirely on-chain and allows its visual appearance to change based on contract state.

### BasicNft.sol
`BasicNft.sol` is a lightweight implementation  of the ERC-721 standard designed to demonstrate the core mechanics of minting traditional NFTs. Rather than generating metadata on-chain, each NFT stores a user-supplied IPFS metadata URI, making it suitable for collections whose metadata and artwork are hosted using decentralized storage. </br>
The contract maintains  a sequential token ID counter,  safely mints new NFTs to users, stores each token's metadata URI, and overrides the standard `tokenURI()` function to return the correct metadata for every token. </br>

#### Collection
```shell
  | Property | Value |
  |----------|-------|
  | Name | Doggie |
  | Symbol | DOG |
  | Standard | ERC-721 |
```

#### Primary Responsibilities
* Mint ERC-721 NFTs.
* Accept custom IPFS metadata URIs during minting.
* Maintain sequential token IDs.
* Store metadata mappings for each token.
* Return token metadata through `tokenURI()`.
* Safely mint NFTs using OpenZeppelin's `_safeMint()`.

### MoodNft.sol
`MoodNft.sol` is a dynamic ERC-721 implementation that demonstrates how NFTs can evolve after minting. Instead of relying on external metadata stored on IPFS, the contract generates its metadata entirely on-chain by dynamically constructing JSON metadata and encoding it as a Base64 Data URI. </br>
Each NFT contains one of two emotional states **HAPPY** or **SAD** represented by on-chain SVG artwork. Owners (or approved operators) can change an NFT's mood through the `flipmood()` function, causing the artwork returned by `tokenURI()` to update automatically without modifying the NFT itself.

#### Collection
```shell
| Property | Value |
|----------|-------|
| Name | Mood NFT |
| Symbol | MN |
| Standard | ERC-721 |
```
#### Primary Responsibilities
* Mint dynamic ERC-721 NFTs.
* Generate metadata entirely on-chain.
* Generate JSON metadata dynamically.
* Store SVG artwork as Base64 Data URIs.
* Encode metadata using Base64.
* Manage NFT mood state using enums.
* Toggle artwork between Happy and Sad states.
* Restrict mood changes to the owner or approved operator.
* Return fully dynamic metadata through `tokenURI()`.



## Functions

### BasicNft
* **constructor()**: Initializes the `Basic NFT` collection by setting the collection name to `Doggie` and the symbol to `DOG` through the OpenZeppelin ERC-721 constructor.  It also initializes the internal token counter, which is used to assign sequential token IDs to newly minted NFTs.
* **mintNft(string tokenUrl)**: Creates a new ERC-721 NFT and safely assigns ownership to the caller (`msg.sender`). During the minting process, the supplied metadata URI is stored and permanently associated with the newly created token before the NFT is minted. </br>
This function allows users to mint NFTs that reference metadata hosted on decentralized storage platforms such as IPFS.
* **tokenURI(uint256 tokenId)**: Returns the metadata URI associated

#### Actions


### MoodNft














## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
