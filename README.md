## Constant Product Automated Market Maker (CPAMM)
Welcome to my **Constant Product Automated Market Maker (CPAMM)** DApp! This project is a full-stack decentralized application that manages a Liquidity Pool on top of the Ethereum Virtual Machine (EVM).
**CPAMM** is driven by the constant product invariant formula $x \cdot y = k$ and allows end users to swap ERC-20 tokens autonomously without the need of order books, and earn Liquidity Provider (LP) shares by supplying a token pair to the pool. 

### Key Features
* **Algorithmic Token Swaps:** Trade any paired ERC-20 tokens with dynamic pricing calculated from the pool's token reserves. 
* **Liquidity Provisioning:** Deposit assets to mint LP shares ($S_{mint} = \frac{dx}{X} \cdot T$) or burn shares to widthdraw underlying reserves proportionally. 
* **Real-Time Analytics Dashboard:** Interactive React interface displaying the live pool reserves ($x$ and $y$).  
* **Comprehensive Test Suite:** Fully covered smart contract logic written in Foundry, validating share minting ratios, zero-amount reverts, and reserve updates. 

### Tech Stack 
* **Smart Contracts:** Solidity, Foundry (Forge and Anvil)
* **Frontend:** Next.js, React, TypeScript
* **Web3 Libraries:** Scaffold-Eth 2, Wagmi, Viem, RainbowKit
* **Styling:** Tailwind CSS, DaisyUI

### Quick Start Guide
* **Clone and install dependencies** 
```sh 
    git clone https://github.com/memorex-96/Automated-Market-Maker-DAPP.git
    cd evm-sandbox 
    yarn install
```
* **Start Local Blockchain**
```sh
    yarn chain
```
* **Deploy Contract to Local Network**
```sh
    yarn deploy
```
* **Launch Frontend Interface**
```sh
    yarn start
```
