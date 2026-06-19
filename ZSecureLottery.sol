// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ZSecureConsumer.sol";

contract ZSecureLottery is ZSecureConsumer {
    
    struct RequestStatus {
        bool fulfilled;
        bool cancelled;
        uint256 requestTimestamp;
        uint256 randomResult;
    }

    mapping(uint256 => RequestStatus) public requests;
    uint256 public constant TIMEOUT_LIMIT = 5 minutos; // Alineado con el safety timeout del motor
    uint256 public latestRequestId;
    address public winner;

    event RandomnessRequested(uint256 indexed requestId, uint256 timestamp);
    event RandomnessFulfilled(uint256 indexed requestId, uint256 result);
    event RequestCancelled(uint256 indexed requestId);

    // Se pasa la dirección del Oráculo de ZSecure en Base
    constructor(address _zsecureOracle) ZSecureConsumer(_zsecureOracle) {}

    /**
     * @dev Gatilla la solicitud de entropía cuántica al coordinador.
     */
    function rollDice() external payable returns (uint256 requestId) {
        requestId = zsecureOracle.requestRandomNumber{value: msg.value}();
        
        requests[requestId] = RequestStatus({
            fulfilled: false,
            cancelled: false,
            requestTimestamp: block.timestamp,
            randomResult: 0
        });
        
        latestRequestId = requestId;
        emit RandomnessRequested(requestId, block.timestamp);
        return requestId;
    }

    /**
     * @dev El hook interno que hereda de ZSecureConsumer.
     * Aquí cae la entropía pura y validada por el core en C++.
     */
    function _consumeRandomness(
        uint256 requestId, 
        uint256 randomNumber, 
        string calldata /* vrfProof */
    ) internal override {
        require(!requests[requestId].fulfilled, "Request already fulfilled");
        require(!requests[requestId].cancelled, "Request was cancelled");

        requests[requestId].fulfilled = true;
        requests[requestId].randomResult = randomNumber;

        // Lógica de negocio de la dApp (Ej: Modular el número para un juego de dados de 1 a 6)
        uint256 diceResult = (randomNumber % 6) + 1;
        
        if (diceResult == 6) {
            winner = msg.sender; 
        }

        emit RandomnessFulfilled(requestId, randomNumber);
    }

    /**
     * @dev RUTA DE CANCELACIÓN EXPLÍCITA (Mencionada en tu Patente INAPI).
     * Si el callback no llega por congestión extrema de la red, el usuario recupera su liveness.
     */
    function cancelExpiredRequest(uint256 requestId) external {
        RequestStatus storage request = requests[requestId];
        
        require(!request.fulfilled, "Already fulfilled");
        require(!request.cancelled, "Already cancelled");
        require(block.timestamp > request.requestTimestamp + TIMEOUT_LIMIT, "Timeout not reached yet");

        request.cancelled = true;
        emit RequestCancelled(requestId);
        
        // Lógica interna para liberar los fondos o re-enviar la transacción segura
    }
}
