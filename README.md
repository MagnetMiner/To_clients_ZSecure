# ZSecure Engine Framework [ES]

[![Patent Pending](https://img.shields.io/badge/INAPI_Chile-Solicitud__2025--04049-blue.svg)](#)
[![Language](https://img.shields.io/badge/Core-C%2B%2B%20%2F%20Low--Level-red.svg)](#)
[![Security](https://img.shields.io/badge/Cryptography-Post--Quantum%20%28PQC%29-green.svg)](#)
[![Architecture](https://img.shields.io/badge/Architecture-Thread--Isolated%20Zeroization-orange.svg)](#)

**ZSecure Engine** es un framework criptográfico distribuido de alto rendimiento diseñado para la generación, validación y distribución de secuencias numéricas aleatorias de alta entropía (True Random Number Generation - TRNG) y blindaje asíncrono post-cuántico (PQC). 

Desarrollado bajo una arquitectura híbrida acoplada multicapa por **ZORD SpA**, el motor combina la velocidad computacional de núcleos binarios nativos en **C++** con proxies perimetrales redundantes de baja latencia. El sistema mitiga activamente el determinismo destructivo introducido por hipervisores en la nube y blinda las comunicaciones críticas contra adversarios cuánticos.

---

## 🏛️ Pilares Arquitectónicos (Procesamiento Multicapa)

El framework opera en 5 fases estancas y secuenciales, garantizando rigidez matemática y resiliencia de infraestructura:

1. **Fase Perimetral (Ingreso Atómico):** Validación de cabeceras inmutables de contexto (`RequestId`, `ChainId`, metadata de red) y débito transaccional inmediato mediante operaciones atómicas en base de datos local para evitar inanición de sockets.
2. **Aislamiento de Entorno (Confinamiento OS):** Orquestación persistente bajo servicios de supervisión nativos del sistema operativo (`systemd`) y segmentación estricta de memoria de acceso aleatorio (RAM) a nivel de hilos de ejecución.
3. **Enlace de Bajo Nivel (ABI/FFI):** Acoplamiento dinámico por referencia utilizando mapeo de punteros binarios de 64 bits hacia el núcleo nativo de alto rendimiento.
4. **Síntesis Estocástica Avanzada:** Extracción multidimensional de ruido térmico del silicio anfitrión combinado con algoritmos adaptativos de **plegamiento espectral**. La densidad y rigidez se evalúan en tiempo real bajo el modelo de **Ensamble Unitario Gaussiano (GUE)** y se certifican mediante una **Función Verificable de Aleatoriedad (VRF)**.
5. **Capa de Entrega Post-Cuántica:** Inyección nativa de firmas basadas en retículos bajo el estándar internacional **ML-DSA (FIPS 204)** directo en la carga útil estructurada.

---

## 🎯 Soluciones por Vertical de Industria

### 1. 🌐 Web3 & Blockchain (DeFi Oracles)
Los oráculos tradicionales sufren vulnerabilidades críticas no por entropía débil, sino por ataques a la infraestructura de comunicación (Front-Running, Replays y manipulación MEV). **ZSecure Engine** destruye estos vectores:
* **Vinculación Criptográfica de Contexto (*Request Binding*):** Cada payload emitido incorpora un certificado VRF ligado indisolublemente a los metadatos de la solicitud. Es válido única y exclusivamente para esa transacción, impidiendo clonaciones en tránsito.
* **Mitigación de Continuación Selectiva:** Las operaciones de control de cuotas y registro mutan el estado de forma atómica *antes* de la revelación de la entropía. Si un actor malicioso abandona el callback tras ver un resultado desfavorable, sus créditos ya han sido debitados sin posibilidad de re-intento bajo el mismo ID.
* **Flujos Asíncronos Transparentes:** Provisión nativa de parámetros de expiración temporal (`client_timeout_safety_seconds`) obligando a los contratos inteligentes consumidores a implementar rutas de cancelación automáticas y seguras (*Request-and-Reveal*).

### 2. ☁️ Servidores Propios & Infraestructura Corporativa (Cloud)
En entornos virtualizados (AWS EC2, Azure, GCP), el aislamiento del hipervisor degrada la entropía del sistema operativo, volviendo predecibles los generadores clásicos.
* **Redundancia Multi-Fuente:** Si el hardware virtualizado atenúa el ruido térmico, el motor conmuta dinámicamente hacia dinámicas de RAM y ASLR del kernel para mantener la densidad estocástica sin degradación de velocidad.
* **Alta Disponibilidad sin Bloqueos:** A diferencia de sistemas que provocan pánicos globales de kernel, ZSecure aísla cada petición en un hilo exclusivo en RAM. Si ocurre una anomalía, la rutina de *zero-ización* limpia estrictamente los registros de ese hilo, manteniendo al servidor host operativo y en línea para el resto de la concurrencia.

### 3. 🏦 Finanzas de Alta Frecuencia (HFT) & Cumplimiento
* **Consumo Eficiente por Lotes (Batching):** La arquitectura permite la gestión local de millones de créditos transaccionales en memoria caché. Los protocolos financieros de alta frecuencia pueden adquirir "épocas" de aleatoriedad off-chain y consumirlas con latencias ultra bajas sin incurrir en costos de gas por transacción individual.
* **Auditoría Matemática Matemática:** La inclusión del score GUE y VRF permite auditorías forenses en tiempo real. Cualquier intento de alteración física del hardware anfitrión se ve reflejado de inmediato en el score de verificación, invalidando la data antes de que impacte los balances.

### 4. 🪖 Defensa y Seguridad Nacional
* **Criptografía Inmune a Computación Cuántica:** Protege el canal de transporte de datos. El payload no se delega a firmas elípticas clásicas expuestas al algoritmo de Shor (como `secp256k1` o `ED25519`). La carga útil viaja firmada de origen con **ML-DSA** (Crystals-Dilithium), asegurando autenticación post-cuántica de extremo a extremo.
* **Anti-Tampering por Software:** Ante la detección de inyecciones de memoria o ataques de canales laterales a nivel de hardware, el hilo de ejecución ejecuta una sobrescritura física destructiva con ceros en RAM de forma inmediata.

---

## 📊 Especificaciones Técnicas de la API

El motor expone endpoints criptográficos de alta velocidad que retornan payloads estructurados auto-verificables on-chain u off-chain:

### Respuesta Estructurada (JSON)
```bash
JSON
{
  "status": "success",
  "timestamp_epoch": "1781905512",
  "context_binding": "verified",
  "entropia_pura": "311789341066061260899216253806907532212",
  "pqc_signature_payload": "7071635f666970733230345f6d6c6473615f656d756c617465645f7369675f626c6f636b5f33376138313838396566663735623136",
  "vrf_score": 99.9887,
  "client_timeout_safety_seconds": 30,
  "creditos_restantes": 1009988
}

### Ejemplo de Solicitud (curl)
```bash
curl -s -H "Authorization: Bearer ZORD-PRO-EXAMPLETOKEN" \
     -H "Content-Type: application/json" \
     -H "X-ZSecure-RequestId: 123456" \
     -H "X-ZSecure-ChainId: 1" \
     http://localhost:10000/api/get_bound_entropy
