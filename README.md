## Constant Product Automated Market Maker (CPAMM)
Welcome to my **Constant Product Automated Market Maker (CPAMM)** DApp! This project is a full-stack decentralized application that manages a Liquidity Pool on top of the Ethereum Virtual Machine (EVM).
**CPAMM** is driven by the constant product invariant formula $x \cdot y = k$ and allows end users to swap ERC-20 tokens autonomously without the need of order books, and earn Liquidity Provider (LP) shares by supplying a token pair to the pool. 

### Key Features
* **Algorithmic Token Swaps:** Trade any paired ERC-20 tokens with dynamic pricing calculated from the pool's token reserves. 
* **Liquidity Provisioning:** Deposit assets to mint LP shares ($S_{mint} = \frac{dx}{X} \cdot T$) or burn shares to widthdraw underlying reserves proportionally. 
* **Real-Time Analytics Dashboard:** Interactive React interface displaying the live pool reserves ($x$ and $y$).  
* **Comprehensive Test Suite:** Fully covered smart contract logic written in Foundry, validating share minting ratios, zero-amount reverts, and reserve updates. 


