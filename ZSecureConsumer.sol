// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IZSecureOracle {
    function requestRandomNumber() external payable returns (uint256 requestId);
}

abstract contract ZSecureConsumer {
    IZSecureOracle public zsecureOracle;
    address private immutable oracleAddress;

    error OnlyZSecureCanFulfill();

    constructor(address _oracleAddress) {
        oracleAddress = _oracleAddress;
        zsecureOracle = IZSecureOracle(_oracleAddress);
    }

    // ESTA ES LA FUNCIÓN EXACTA QUE SU ORÁCULO BUSCARÁ EN EL CLIENTE
    function fulfillZSecureRandomness(uint256 requestId, uint256 randomNumber, string calldata vrfProof) external {
        if (msg.sender != oracleAddress) revert OnlyZSecureCanFulfill();
        
        // Función interna que el cliente personalizará
        _consumeRandomness(requestId, randomNumber, vrfProof);
    }

    // El desarrollador del casino/juego debe sobrescribir esto
    function _consumeRandomness(uint256 requestId, uint256 randomNumber, string calldata vrfProof) internal virtual;
}
