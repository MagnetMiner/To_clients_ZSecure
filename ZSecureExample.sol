// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ZSecureConsumer.sol";

/**
 * @title ZSecureExample
 * @dev Simple lottery example utilizing the ZSecure PQC (Post-Quantum Cryptography) Oracle.
 */
contract ZSecureExample is ZSecureConsumer {
    uint256 public luckyNumber;
    address public lastWinner;

    // Best Practice: Map request IDs to players to identify them in the callback
    // mapping(uint256 => address) public requestToPlayer;

    /**
     * @dev Constructor requires the ZSecure Coordinator address.
     * Base Mainnet Coordinator: 0xEdd63E615A2cE649b14493E520C5A567c784E6D6
     */
    constructor(address _coordinator) ZSecureConsumer(_coordinator) {}

    /**
     * @dev Initiates the request for post-quantum entropy.
     * Requires a flat fee of 0.0001 ETH to cover gas and relay costs.
     */
    function play() external payable {
        // Enforce the exact fee for the Beta Tier
        require(msg.value == 0.0001 ether, "ZSecure: Exact fee required (0.0001 ETH)");

        // Request entropy from the ZSecure Oracle
        zsecureOracle.requestRandomNumber{value: msg.value}();

        // Note for production: Capture the returned requestId and map it to msg.sender
        // uint256 requestId = zsecureOracle.requestRandomNumber{value: msg.value}();
        // requestToPlayer[requestId] = msg.sender;
    }

    /**
     * @dev Callback function called automatically by the ZSecure Relayer.
     * @param requestId The ID of the entropy request.
     * @param randomNumber The post-quantum random number delivered.
     * @param vrfProof The cryptographic proof of the quantum entropy.
     */
    function _consumeRandomness(uint256 requestId, uint256 randomNumber, string calldata vrfProof) internal override {
        luckyNumber = randomNumber;
        
        // CAUTION: msg.sender here is the ZSecure Relayer, NOT the player.
        // In a production environment, resolve the winner using the requestId:
        // lastWinner = requestToPlayer[requestId];
    }
}
