Markdown
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
    constructor() ZSecureConsumer(0xYour_ZSecure_Oracle_Address_Here) {}
}
Step 2: Request Entropy
Call the requestRandomNumber function provided by the parent contract. You only need to send the exact native fee required for the transaction.

Solidity
    function rollDice() external payable {
        // Request a random number. The Oracle handles the rest.
        zsecureOracle.requestRandomNumber{value: 0.0001 ether}(); 
    }
Step 3: Receive and Use the Entropy
Override the _consumeRandomness internal function. The ZSecure Relayer will automatically call this function asynchronously to deliver your pure quantum entropy.

Solidity
    uint256 public latestRandomResult;

    function _consumeRandomness(uint256 requestId, uint256 randomNumber, string calldata vrfProof) internal override {
        // Your core game logic goes here!
        latestRandomResult = randomNumber;
    }

🛡️ Security & Reliability
PQC Entropy: Generated off-chain using quantum-resistant algorithms.

Encapsulated Call: Delivery is capped at 150,000 gas to protect the relayer while ensuring delivery.

Strict Access Control: The consumer contract only accepts inputs from the verified ZSecure Master Oracle.

Redundancy: Powered by high-availability AWS nodes and Rust-based relayers.

🎯 Try it yourself! Check out the ZSecureExample.sol file in this repository for a fully working lottery implementation.
