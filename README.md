# To_clients_ZSecure
ZSecure Oracle - Integration Protocol
🌐 ZSecure Oracle - Integration Protocol
🇺🇸 English
ZSecure PQC Oracle - Official Consumer Template
This folder contains the official smart contract template (ZSecureConsumer.sol) required to integrate your decentralized application (dApp, DeFi, or Web3 Game) with the ZSecure Post-Quantum Cryptography (PQC) Entropy Engine.

How to integrate:

Inherit: Make your main contract inherit from ZSecureConsumer.

Request: Call the requestRandomNumber() function inherited from the oracle, attaching the required network fee (e.g., 0.0001 ETH).

Consume: Override the internal virtual function _consumeRandomness(uint256 requestId, uint256 randomNumber, string calldata vrfProof). The ZSecure off-chain relay will automatically call this function to safely deliver the quantum entropy directly into your contract's logic.
Security Note: The delivery gateway is hardcoded to reject any input that does not come exclusively from the verified ZSecure Master Oracle.

🇪🇸 Español
Oráculo ZSecure PQC - Plantilla Oficial de Integración
Esta carpeta contiene la plantilla oficial del contrato inteligente (ZSecureConsumer.sol) requerida para integrar su aplicación descentralizada (dApp, DeFi o Juego Web3) con el Motor de Entropía de Criptografía Post-Cuántica (PQC) de ZSecure.

Cómo integrar:

Heredar: Haga que su contrato principal herede de ZSecureConsumer.

Solicitar: Llame a la función requestRandomNumber() heredada del oráculo, adjuntando la tarifa de red requerida (ej. 0.0001 ETH).

Consumir: Sobrescriba (override) la función virtual interna _consumeRandomness(uint256 requestId, uint256 randomNumber, string calldata vrfProof). El relé off-chain de ZSecure llamará automáticamente a esta función para entregar de forma segura la entropía cuántica directamente en la lógica de su contrato.
Nota de Seguridad: La puerta de enlace está programada para rechazar cualquier entrada que no provenga exclusivamente del Oráculo Maestro verificado de ZSecure.

🇯🇵 日本語 (Japanese)
ZSecure PQC オラクル - 公式統合テンプレート
このフォルダには、分散型アプリケーション (dApp、DeFi、Web3ゲームなど) を ZSecure のポスト量子暗号 (PQC) エントロピーエンジンと統合するために必要な、公式のスマートコントラクトテンプレート (ZSecureConsumer.sol) が含まれています。

統合手順:

継承: メインのコントラクトに ZSecureConsumer を継承させます。

リクエスト: オラクルから継承した requestRandomNumber() 関数を呼び出し、必要なネットワーク手数料 (例: 0.0001 ETH) を添付します。

消費: 内部の仮想関数 _consumeRandomness(uint256 requestId, uint256 randomNumber, string calldata vrfProof) をオーバーライドします。ZSecureのオフチェーンリレーが自動的にこの関数を呼び出し、量子エントロピーをコントラクトのロジックに直接かつ安全に配信します。
セキュリティに関する注意事項: 配信ゲートウェイは、検証済みのZSecureマスターオラクル以外からの入力をすべて拒否するようにハードコーディングされています。

🇨🇳 中文 (Simplified Chinese)
ZSecure PQC 预言机 - 官方集成模板
此文件夹包含官方智能合约模板 (ZSecureConsumer.sol)，用于将您的去中心化应用程序（dApp、DeFi 或 Web3 游戏）与 ZSecure 后量子密码学 (PQC) 熵引擎集成。

如何集成：

继承： 让您的主合约继承 ZSecureConsumer。

请求： 调用从预言机继承的 requestRandomNumber() 函数，并附带所需的网络费用（例如 0.0001 ETH）。

消耗： 重写内部虚拟函数 _consumeRandomness(uint256 requestId, uint256 randomNumber, string calldata vrfProof)。ZSecure 链下中继将自动调用此函数，将量子熵安全地直接传送到您的合约逻辑中。
安全提示：交付网关已在代码层面硬性规定，拒绝任何非来自经过验证的 ZSecure 主预言机的输入。
