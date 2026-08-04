# NFT Smart Contracts


## Project Overview
This repository contains two ERC-721 Non-Fungible Token (NFT) smart contracts built with `Solidity`, `OpenZeppelin`, and the `Foundry` development framework. The project showcases both traditional and dynamic NFT implementations while demonstrating best practices for NFT development, deployment, testing, and interaction. </br>
The repository includes two NFT collections:
* **Basic NFT**: A standard ERC-721 implementation that allows users to mint NFTs using off-chain metadata stored on IPFS.
* **Mood NFT**: A dynamic ERC-721 implementation that generates metadata entirely on-chain. The NFT artwork changes between `Happy` and `Sad` states, with both SVG images and metadata encoded using `Base64 Data URIs`. </br>
In addition to the smart contracts, the project provides deployment scripts, interaction scripts, unit tests, and integration tests, offering a complete end-to-end example of building, deploying, testing, and interacting with ERC-721 NFTs using Foundry. with a specific NFT. This function testing into distinct components.



## Architecture
The project follows a modular architecture that separates NFT logic, deployment automation,  contract interactions, and This separation improves maintainability, readability, and extensibility while making the repository easier to understand and expand. </br>
The repository demonstrates two different approaches to ERC-721 NFT development: </br>

* **Basic NFT**: which stores metadata off-chain using IPFS.
* **Mood NFT**: which generates metadata entirely on-chain using Base64-encoded JSON and SVG images. </br>

### High-Level Architecture
```shell
                              +----------------------+
                              |        User          |
                              +----------+-----------+
                                         |
                          Mint / View / Update NFT
                                         |
                 +-----------------------+-----------------------+
                 |                                               |
                 ▼                                               ▼
        +----------------------+                      +----------------------+
        |      BasicNft        |                      |       MoodNft        |
        |----------------------|                      |----------------------|
        | ERC721               |                      | ERC721               |
        | Mint NFTs            |                      | Mint NFTs            |
        | Store IPFS URI       |                      | Store Mood State     |
        | Return tokenURI()    |                      | Generate Metadata    |
        +----------+-----------+                      | Base64 Encoding      |
                   |                                  | SVG Artwork          |
                   |                                  +----------+-----------+
                   |                                             |
                   ▼                                             ▼
           +----------------+                        +------------------------+
           | IPFS Metadata  |                        | On-chain Metadata      |
           | JSON + Images  |                        | JSON + SVG Data URI    |
           +----------------+                        +------------------------+

                         +--------------------------------+
                         |     Foundry Development         |
                         |--------------------------------|
                         | Deployment Scripts             |
                         | Interaction Scripts            |
                         | Unit Tests                     |
                         | Integration Tests              |
                         +--------------------------------+
```


### Repository Components
The repository is organized into several independent components, each with a dedicated responsibility. </br>


#### Smart Contracts
The `src` directory contains the core ERC-721 smart contracts. Implements a traditional ERC-721 NFT where metadata is stored externally using IPFS.

* **BasicNft.sol**: </br>

Responsibilities include: </br>
1. Minting NFTs.
2. Assigning ownership.
3. Managing sequential token IDs.
4. Storing metadata URIs.
5. Returning token metadata.

* **MoodNft.sol**: Implements a dynamic ERC-721 NFT capable of changing its appearance after minting. </br>

Responsibilities include: </br>
1. Minting NFTs.
2. Managing mood states.
3. Generating metadata on-chain.
4. Encoding JSON using Base64.
5. Encoding SVG artwork.
6. Dynamically updating NFT artwork.


#### Deployment Layer
Deployment scripts automate contract deployment using Foundry. </br>

* **DeployBasicNft.s.sol**: </br>

Responsible for: </br>
1. Deploying the Basic NFT collection.
2. Initializing collection metadata.
3. Broadcasting deployment transactions.

* **DeployMoodNft.s.sol**:

Responsible for: </br>
1. Reading SVG artwork.
2. Encoding SVG images into Base64 Data URIs.
3. Deploying the Mood NFT contract.
4. Passing artwork to the constructor.


#### Interaction Layer
Interaction scripts simplify common user operations after deployment. </br>

Supported interactions include: </br>
1. Minting Basic NFTs.
2. Minting Mood NFTs.
3. Flipping NFT moods.
4. Automatically locating the latest deployed contract using Foundry DevOps tools.


#### Testing Layer
The repository includes both unit and integration testing. </br>

* **Unit Tests**:
Validate individual components  in isolation, including: </br>
1. SVG encoding.
2. Deployment utilities.
3. Internal helper functions
  
* **Integration Tests**:
Validate complete workflows, including: </br>
1. Contract deployment.
2. NFT minting.
3. Metadata generation.
4. Mood switching.
5. Ownership validation.

### Component Relationships
```shell
            +----------------------+
            |        User          |
            +----------+-----------+
                       |
                       ▼
             Calls Contract Functions
                       |
       +---------------+---------------+
       |                               |
       ▼                               ▼
+---------------+               +---------------+
|   BasicNft    |               |    MoodNft    |
+-------+-------+               +-------+-------+
       |                               |
       ▼                               ▼
Stores IPFS URI               Generates Metadata
       |                               |
       ▼                               ▼
   IPFS Storage            Base64 JSON + SVG
                      
       ▲                               ▲
       |                               |
+-------+-------------------------------+------+
|            Interaction Scripts               |
+-----------------------+----------------------+
                       |
                       ▼
             Deployment Scripts
                       |
                       ▼
                 Foundry Framework           
```


### System Workflow

#### Basic NFT Flow
```shell
User
 │
 │ mintNft(IPFS URI)
 ▼
BasicNft
 │
 ├── Stores metadata URI
 ├── Safely mints NFT
 ├── Assigns ownership
 └── Increments token ID
       │
       ▼
NFT Created
       │
       ▼
Marketplace calls tokenURI()
       │
       ▼
Metadata fetched from IPFS
```

#### Mood NFT Flow
```shell
  Deploy Contract
 │
 ▼
Load SVG Files
 │
 ▼
Convert SVG → Base64
 │
 ▼
Deploy MoodNft
 │
 ▼
User mints NFT
 │
 ▼
Mood = HAPPY
 │
 ▼
flipmood()
 │
 ▼
Mood Changes
 │
 ▼
tokenURI()
 │
 ▼
Generate JSON Metadata
 │
 ▼
Encode Metadata
 │
 ▼
Return Data URI
```


### Design Principles
The architecture follows  several important software engineering principles: </br>
1. **Modularity**: Smart contracts, deployment scripts, interaction scripts, and tests are separated into dedicated components.
2. **Single Responsibility Principle**: Each contract and script performs a well-defined task.
3. **Standards Compliance**:  Built on OpenZeppelin's ERC-721 implementation.
4. **Automation**: Foundry scripts automate deployment and post-deployment interactions.
5. **Security**: Ownership checks restrict sensitive state changes such as mood updates.
6. **Maintainability**: Clear separation of concerns simplifies future enhancements and testing.
7. **Extensibility**: Additional NFT collections,  metadata strategies, or interaction scripts can be integrated with minimal architectural changes.




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
* **tokenURI(uint256 tokenId)**: Returns the metadata URI associated overrides OpenZeppelin's default implementation to retrieve the custom metadata URI stored during minting.


### MoodNft
* **constructor(string sadSvgImageUri, string happySvgImageUri)**: Initializes the `Mood NFT` collection by configuring the collection name, symbol, and the SVG artwork used to represent each mood state. The supplied SVG images are stored as Base64-encoded Data URIs and serve as the visual assets  for every NFT minted by the contract. The constructor also initializes the internal token counter used to assign sequential token IDs.
* **mintNft()**: Creates a new dynamic NFT and safely assigns ownership to the caller.  Every newly minted NFT begins with its mood initialized to `HAPPY`. </br>
Unlike the Basic NFT contract, no external metadata URI is required because all metadata is generated entirely on-chain.
* **flipmood(uint256 tokenId)**: Updates the emotional state of an NFT by toggling its mood between `HAPPY` and `SAD`. Before performing the update, the contract verifies that the caller is either the token owner or an approved operator. Changing the mood automatically changes the artwork and metadata returned by future calls to `tokenURI()`.
* **tokenURI(uint256 tokenId)**: Generates the NFT metadata entirely on-chain. The function determines the NFT's current mood, selects the appropriate SVG artwork, dynamically constructs a JSON metadata object, Base64-encodes the JSON, and returns it as a Data URI compatible with ERC-721 wallets and marketplaces. </br>
Unlike traditional NFTs that reference metadata stored on IPFS,  this implementation generates metadata on demand whenever `tokenURI()` is called.
* **_baseURI()**: An internal helper function that returns the standard prefix used when constructing Base64-encoded JSON metadata. </br>
This function is overridden from OpenZeppelin's ERC721 implementation and is used internally by `tokenURI()`.



## Technologies Used
The project is built using a modern Ethereum development stack focused on standards-compliant NFT development, deployment automation,  and comprehensive testing. The following technologies and  tools were used throughout the project. </br>
* **Solidity (^0.8.18)**: The primary programming language used to develop the ERC-721 smart contracts and implement the NFT logic.
* **Foundry**: An Ethereum development framework used for compiling, testing, deploying, debugging, and interacting with the smart contracts through automated scripts.
* **OpenZeppelin Contracts**


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
