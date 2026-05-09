# 🛡️ ZSecure Oracle - Integration Protocol

ZSecure PQC Oracle is an institutional-grade Entropy Engine designed for dApps, DeFi, and Web3 Games on Base. It leverages Post-Quantum Cryptography (PQC) off-chain to deliver verifiable randomness with high security and low latency.

---

## 🚀 Quick Start: 3-Step Integration

Integrating ZSecure Oracle into your Smart Contract is frictionless. No complex subscription managers, no hidden gas overhead. Just plug and play.

### Step 1: Inherit the Consumer
Download `ZSecureConsumer.sol` and import it into your contract. Inherit from it and pass the ZSecure Oracle Coordinator address to the constructor.

```solidity
import "./ZSecureConsumer.sol";

contract MyGame is ZSecureConsumer {
    // ⚠️ Replace with the official ZSecure Oracle Address on Base
    constructor() ZSecureConsumer(0xEdd63E615A2cE649b14493E520C5A567c784E6D6) {}
}
