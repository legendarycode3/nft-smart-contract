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
*  Smart contract interaction scripts for minting and state updates


### Basic NFT Features

### Mood NFT Features


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
