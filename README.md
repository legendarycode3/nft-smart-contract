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



## How It Works
This project implements a dynamic ERC-721 Mood NFT where each token has an on-chain mood state that can change between `HAPPY` and `SAD`. </br>
The NFT artwork is stored directly in the smart contract as Base64-encoded SVG data, while tokenURI() dynamically generates the metadata and artwork based on the token's current mood. </br>


### Basic NFT Minting Flow
The Basic NFT follows a straightforward ERC-721 minting and metadata flow.

```shell
  User
  │
  │ mintNft(tokenUrl)
  ▼
Generate Token ID
  │
  ▼
Store Metadata URI
  │
  ▼
_safeMint()
  │
  ▼
Assign NFT Ownership
  │
  ▼
Increment Token Counter
  │
  ▼
NFT Created
``` 
When a user calls `mintNft()`, the contract generates a unique token ID, stores the associated metadata URI, and safely mints the ERC-721 token using OpenZeppelin's `_safeMint()` implementation. The newly created NFT is assigned to the recipient and becomes part of the collection. </br>
Every newly minted Mood NFT


### Mood NFT Minting Flow
The Mood NFT implements a dynamic NFT architecture where the visual representation of each token can change after minting.
```shell
  User
   │
   │  mintNft()
   ▼
  MoodNft Contract
   │
   ├── Generate Token ID
   │
   ├── _safeMint(msg.sender, tokenId)
   │
   ├── Set Mood = HAPPY
   │
   └── Increment Token Counter
   │
   ▼
  NFT Successfully Minted
   │
   ▼
  Initial State
  Mood = HAPPY
```
`mintNft()`, the contract generates a unique token ID using the token counter and safely mints the NFT to the caller. starts in the `HAPPY` state. The corresponding mood is stored in the `s_tokenIdToMood` mapping, allowing each NFT to maintain its own independent state.


#### Fully On-Chain Mood NFT Architecture
The Mood NFT's artwork and metadata follow an entirely on-chain data flow.
```shell
                           MOOD NFT ON-CHAIN FLOW

SVG Files
   │
   │ Deployment
   ▼
Base64 Encoding
   │
   ▼
MoodNft Contract
   │
   ├── Happy SVG URI
   └── Sad SVG URI
          │
          ▼
     User Mints NFT
          │
          ▼
      Mood = HAPPY
          │
          ▼
       tokenURI()
          │
          ▼
  Select Current Artwork
          │
          ▼
  Generate JSON Metadata
          │
          ▼
      Base64 Encode
          │
          ▼
     Data URI Returned
```
The deployment script reads the Happy and Sad SVG files from the repository and converts them into Base64-encoded image Data URIs before passing them to the `MoodNft` constructor. </br>
After deployment, the artwork is stored within the contract and reused whenever metadata is generated. This removes the need for an external metadata server or IPFS dependency for the Mood NFT.


### Complete Project Flow  



## Technologies Used
The project is built using a modern Ethereum development stack focused on standards-compliant NFT development, deployment automation,  and comprehensive testing. The following technologies and  tools were used throughout the project. </br>
* **Solidity (^0.8.18)**: The primary programming language used to develop the ERC-721 smart contracts and implement the NFT logic.
* **Foundry**: An Ethereum development framework used for compiling, testing, deploying, debugging, and interacting with the smart contracts through automated scripts.
* **OpenZeppelin Contracts**: Provides secure and audited implementations of the ERC-721 standard, enabling standards-compliant NFT ownership, transfers, approvals,  and safe minting.
* **ERC-721 Standard**: Defines the standard interface for non-fungible tokens, ensuring compatibility with wallets, marketplaces, and blockchain explorers.



## Getting Started
### Prerequisites
* [FOUNDRY](https://www.getfoundry.sh/introduction/installation) </br>
    * Verify installation: `forge --version`
* [GIT](https://git-scm.com/) </br>
    * Verify installation: `git --version`


### Installation
1. Clone the repository: </br>
```shell
    https://github.com/legendarycode3/nft-smart-contract
```
```shell
    cd nft-smart-contract
```
2. Install dependencies: </br>
```shell
    make install
```
3. Build the project: </br>
```shell
   forge build
```
Or, if using the provided `Makefile`: </br>
```shell
   make build
```


## Usage



## Testing
The project uses Foundry and `forge-std` to test the NFT contracts, deployment utilities,  metadata generation, and dynamic mood behavior. </br>

#### Run Tests
Run the complete test suite: </br>
```shell
  forge test
```
#### Run tests with detailed execution traces:
```shell
  forge test -vvvv
```

### Test Coverage
The test suite covers: </br>
* Basic NFT deployment and configuration.
* Basic NFT minting and ownership.
* Basic NFT metadata URI retrieval.
* Mood NFT deployment and minting.
* Initial `HAPPY` mood assignment.
* Mood switching between `HAPPY` and `SAD`.
* Dynamic on-chain metadata generation.
* Base64 JSON and SVG encoding.
* SVG-to-Data-URI conversion.
* Deployment and contract integration workflows.



## Gas Optimizations
The smart contracts incorporate several gas optimization techniques to reduce deployment costs, minimize transaction execution fees, and improve overall contract efficiency while maintaining readability and compliance with the ERC-721 standard. </br>

* **Sequential Token IDs**: Both NFT contracts use a simple incremental counter to generate unique token IDs. This approach avoids unnecessary computations and provides an efficient mechanism for assigning identifiers to newly minted NFTs.
* **Optimized Storage Mappings**: Token metadata and mood states are stored using Solidity mappings, enabling constant-time (`O(1)`) lookups while avoiding the overhead associated with more complex storage structures.
* **Custom Errors**: The `MoodNft` contract uses custom Solidity errors instead of revert strings for access control validation. This reduces deployment bytecode size and significantly lowers gas consumption whenever a transaction reverts.
* **Compact Enum Storage**: The NFT mood is represented using a Solidity `enum`, which stores the state in a compact format. Compared to storing strings or larger data types, enums require less storage and reduce gas costs for both reads and writes.
* **One-Time SVG Encoding**: SVG artwork is converted into Base64 Data URIs during deployment and stored only once within the contract. This eliminates repeated encoding operations and allows the same artwork to be reused whenever NFT metadata is requested.
* **Dynamic Metadata Generation**: Rather than storing complete metadata for every NFT on-chain, the `MoodNft` contract generates JSON metadata dynamically within the `tokenURI()` function. This minimizes persistent storage usage while ensuring the returned metadata always reflects the NFT's current mood.
* **Minimal Persistent Storage**: Both contracts maintain only the essential state variables required for their functionality, reducing expensive storage operations and lowering deployment and execution costs.
* **Inherited ERC-721 Implementation**: By leveraging OpenZeppelin's optimized ERC-721 implementation, the contracts benefit from well-tested and gas-conscious token management logic instead of duplicating standard functionality.
* **Efficient State Updates**: State variables are modified only when necessary. For example, mood changes update only the affected NFT's state, while minting operations write only the required ownership, metadata, and token counter values, avoiding unnecessary storage writes.
* **Lightweight Contract Architecture**: Each contract focuses on a single responsibility—either managing traditional NFTs or dynamic NFTs. This modular design keeps contract logic compact, reducing deployment size and making execution more efficient.



## Security Considerations
The project incorporates several  security-focused design decisions to promote standards compliance,  protect NFT ownership, and reduce common smart contract risks. While the contracts are intentionally lightweight, they follow established Ethereum development best practices and leverage trusted libraries wherever possible. </br>
* **Ownership and Approval Verification**: The `MoodNft` contract restricts mood updates to the NFT owner or an approved operator. Before allowing a mood change, the contract verifies the caller's authorization, preventing unauthorized users from modifying another user's NFT.
* **OpenZeppelin ERC-721 Implementation**: Both NFT contracts inherit from OpenZeppelin's audited ERC-721 implementation, providing secure and standards-compliant functionality for NFT ownership, transfers, approvals, and safe minting while reducing the risk of introducing vulnerabilities through custom implementations.
* **Safe NFT Minting**: NFTs are minted using the `_safeMint()` function, ensuring that tokens sent to smart contracts are transferred only if the receiving contract correctly implements the ERC-721 receiver interface. This helps prevent NFTs from becoming permanently locked in incompatible contracts.
* **Custom Errors**: Access control failures use custom Solidity errors instead of revert strings. Custom errors also provide clear and structured failure conditions without increasing deployment size.
* **Immutable Artwork Configuration**: The Happy and Sad SVG image URIs are supplied during deployment and  remain unchanged throughout the contract's lifetime. This ensures the NFT artwork cannot be altered after deployment, providing predictable and consistent metadata.
* **Minimal External Surface Area**: The contracts expose only the functions necessary for minting NFTs, retrieving metadata, and updating NFT moods. Keeping the public interface small reduces the overall attack surface and simplifies security analysis.
* **No Ether Handling**: The contracts are not payable and do not accept, store, or transfer Ether. By avoiding payment logic, they eliminate an entire class of financial vulnerabilities such as accidental fund locking or Ether withdrawal issues.
* **Standards Compliance**: Adhering to the ERC-721 specification ensures compatibility with wallets, marketplaces, and blockchain infrastructure while relying on well-established interfaces that have undergone extensive community review.



## Potential Risks & Assumptions
### Basic NFT
* **IPFS Metadata Availability**: The NFT metadata is stored on IPFS rather than directly on-chain. While IPFS provides decentralized storage, the metadata remains accessible only as long as the content is properly pinned or hosted by one or more IPFS nodes. If the content is no longer pinned, the metadata may become temporarily or permanently unavailable.
* **Immutable Metadata**: Once an NFT is minted, its metadata URI is permanently assigned and cannot be modified. This immutability ensures consistency and trust but also means that any mistakes in the uploaded metadata (such as incorrect attributes, image links, or descriptions) cannot be corrected after deployment.
* **Metadata Integrity**: The contract assumes that all metadata files were correctly created, uploaded, and linked before deployment. Invalid JSON formatting, broken IPFS links, or incorrect image references will result in incomplete or inaccessible NFT metadata across wallets and marketplaces.
* **External Storage Dependency**:  Although ownership records are stored securely on-chain, the associated images and metadata are maintained off-chain through IPFS. The long-term availability of these assets depends on maintaining reliable decentralized storage infrastructure.
*  **Token ID Assumption**: Token IDs are generated sequentially  starting from zero. The implementation assumes that the internal counter remains the sole mechanism for generating new token IDs.

### Mood NFT
* **On-Chain Metadata Size**: SVG artwork and metadata are stored as Base64-encoded strings within the contract.  Larger SVG files increase deployment size and can significantly increase deployment gas costs.
* **Deployment Cost**: Because the SVG artwork is embedded into the contract during deployment, deploying `MoodNft` can be considerably more expensive than deploying a minimal ERC-721 contract.
* **Dynamic Metadata Generation**: The `tokenURI()` function dynamically constructs and Base64-encodes the NFT metadata whenever it is queried. This increases computational work compared with returning a pre-stored metadata URI.
* **Gas Consumption of `tokenURI()`**:  Although `tokenURI()` is normally called as a read-only operation, applications interacting with the function on-chain or through other contracts may incur additional computational costs due to dynamic metadata generation.
* **Artwork Immutability**: The Happy and Sad SVG URIs are supplied during deployment and cannot be changed afterward. If incorrect artwork is provided during deployment, the contract does not include an administrative mechanism for replacing it.
* **Limited Mood States**: The contract currently supports only two predefined states: `HAPPY` and `SAD`. Adding additional moods would require modifying the contract implementation and  redeploying it.
* **Metadata Attribute Limitation**: The current metadata uses a fixed `moodiness` attribute with a value of `100`. The attribute does not dynamically represent the current Happy or Sad state.
* **Token Existence**: Functions such as `tokenURI()` and `flipmood()` assume that the referenced token ID exists. Applications interacting with the contract should ensure that they operate on valid, minted token IDs.
* **Approval Assumption**: The mood-changing mechanism allows the NFT owner or an approved address to modify the token's mood. Users should understand that granting approval to another address also grants that address permission to change the NFT's mood.

### General Assumptions
* **OpenZeppelin Dependency**: The contracts rely on OpenZeppelin's ERC-721 implementation and assume the imported dependency  remains compatible with the project's Solidity version.
* **Correct Deployment Configuration**: The deployment scripts assume that the required SVG files exist at the expected paths and contain valid SVG content.
* **Trusted Deployment Environment**: Deployment scripts use Foundry broadcasting and therefore assume that the configured deployer  account and private-key environment are correctly secured.
* **No Financial Logic**: The contracts do not implement payments,  royalties, staking, or financial mechanisms. Consequently, economic security considerations associated with those systems are outside the scope of this project.
* **Testing Does Not Guarantee Complete Security**: The included unit and integration tests validate important contract behaviors but cannot guarantee that the contracts are completely free from vulnerabilities.
* **Production Deployment Requires Additional Review**: Before deploying these contracts to a production network or using them in a high-value NFT collection, the contracts should undergo additional security review, testing, and potentially an independent smart contract audit.



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
