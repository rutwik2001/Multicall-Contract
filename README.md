## 🔗 Multicall Smart Contract – Holdings MVP

This repository contains the **custom Solidity Multicall contract** used in the [Holdings MVP](https://github.com/rutwik2001/holdings-mvp) project. It is designed to efficiently batch-fetch **ERC-20** and **native token** balances for multiple wallet addresses across EVM-compatible blockchains.

---

## ✨ Why a Custom Multicall?

Standard multicall contracts (e.g., Multicall3) can batch-read ERC-20 data but **cannot batch native token balances**, requiring additional RPC calls. This contract solves that by:

- ✅ Supporting both **ERC-20 and native tokens** in one call
- ✅ Reducing RPC overhead significantly across users, tokens, and chains
- ✅ Allowing custom logic and formatting for frontend/backend consumption
- ✅ Providing **on-chain control** and upgradability

---

## 🛠 Tech Stack

- **Solidity**
- **Hardhat** for development, testing, and deployment
- **ethers.js** for integration

---



## ⚙️ Setup Instructions

### 1. Install Dependencies

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Multicall.ts
------------Deployment to network------------------
npx hardhat ignition deploy ./ignition/modules/Multicall.ts --network <network>
```
