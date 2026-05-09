// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title IZSecureOracle
 * @dev Interface for interacting with the ZSecure Post-Quantum Oracle Coordinator.
 */
interface IZSecureOracle {
    function requestRandomNumber() external payable returns (uint256 requestId);
}

/**
 * @title ZSecureConsumer
 * @dev Abstract contract to be inherited by dApps requiring quantum-resistant entropy.
 */
abstract contract ZSecureConsumer {
    IZSecureOracle public zsecureOracle;
    address private immutable oracleAddress;

    error OnlyZSecureCanFulfill();

    /**
     * @dev Initializes the consumer with the official ZSecure Coordinator address.
     * @param _oracleAddress Address of the ZSecure Oracle on the specific network.
     */
    constructor(address _oracleAddress) {
        oracleAddress = _oracleAddress;
        zsecureOracle = IZSecureOracle(_oracleAddress);
    }

    /**
     * @dev Callback function called EXCLUSIVELY by the ZSecure Relayer to deliver entropy.
     * Do not modify the signature of this function, as the Relayer expects it exactly as is.
     * * @param requestId The ID assigned to the randomness request.
     * @param randomNumber The generated post-quantum random number.
     * @param vrfProof The cryptographic proof verifying the entropy.
     */
    function fulfillZSecureRandomness(uint256 requestId, uint256 randomNumber, string calldata vrfProof) external {
        // Security Check: Only the official Oracle Coordinator can inject data
        if (msg.sender != oracleAddress) revert OnlyZSecureCanFulfill();
        
        // Pass the verified data to the internal logic hook
        _consumeRandomness(requestId, randomNumber, vrfProof);
    }

    /**
     * @dev Internal hook that the dApp developer (e.g., casino/game) must override.
     * This is where the custom logic for utilizing the randomness is implemented.
     * * @param requestId The ID of the fulfilled request.
     * @param randomNumber The post-quantum entropy delivered.
     * @param vrfProof The cryptographic proof.
     */
    function _consumeRandomness(uint256 requestId, uint256 randomNumber, string calldata vrfProof) internal virtual;
}
