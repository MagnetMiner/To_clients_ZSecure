// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ZSecureConsumer.sol";

/**
 * @title ZSecureExample
 * @dev Ejemplo simple de un sorteo que usa el Oráculo ZSecure.
 */
contract ZSecureExample is ZSecureConsumer {
    uint256 public luckyNumber;
    address public lastWinner;

    // Al desplegar, el cliente pone la dirección de su ZSecure Oracle Coordinator:
    // 0xEdd63E615A2cE649b14493E520C5A567c784E6D6
    constructor(address _coordinator) ZSecureConsumer(_coordinator) {}

    function play() external payable {
        // El cliente solicita el número y paga la tarifa (0.0001 ETH)
        zsecureOracle.requestRandomNumber{value: 100000000000000}();
    }

    // Esta función la llama su Oráculo automáticamente:
    function _consumeRandomness(uint256 requestId, uint256 randomNumber, string calldata vrfProof) internal override {
        luckyNumber = randomNumber;
        lastWinner = msg.sender; // En un caso real, aquí iría la lógica del juego
    }
}
