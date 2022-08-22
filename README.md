# foundry-chainlink

[Foundry](https://book.getfoundry.sh/) project that demonstrates usage of [Chainlink VRF](https://docs.chain.link/docs/vrf/v2/introduction/) and [Chainlink Keepers](https://docs.chain.link/docs/chainlink-keepers/introduction/) on [Polygon Mumbai Testnet](https://docs.chain.link/docs/vrf/v2/supported-networks/#polygon-matic-mumbai-testnet).

## Summary

Chainlink VRF generates one or more random values and cryptographic proof of how those values were determined. 
VRF v2 requests receive funding from subscription accounts. Users pre-pay for VRF v2 so they don't have to provide funding each time their application requests randomness.
For Chainlink VRF v2 to fulfill your requests, you must maintain a sufficient amount of LINK in your subscription balance.

[End-to-end diagram](https://docs.chain.link/images/vrf/v2-subscription-e2e.webp)

### Setup VRF Subscriber 

[Chainlink VRF Subscription Manager](https://vrf.chain.link/)

- Create a subscription
- Fund it with LINK token
- Add consumer contracts

## Useful commands and resources

### Install Chainlink contracts

```sh
forge install https://github.com/smartcontractkit/chainlink-brownie-contracts
```

### Install OpenZeppelin contracts

```sh
forge install openzeppelin/openzeppelin-contracts
```

[Chainlink VRF Subscription Manager](https://vrf.chain.link/mumbai)

## Mumbai Transactions and contracts

Test Wallet :
https://mumbai.polygonscan.com/address/0x235596f35fdeac45a59bf38640dd68f19a85de39

### VRF

Creation of a subscription :
https://mumbai.polygonscan.com/tx/0x5996624f36c9c925df910e35ab330060195c77d907b1b978a67cb7770b7a8b3c

Add funds (3 LINK) to subscription :
https://mumbai.polygonscan.com/tx/0xd85fa9480d93506b07214d2408b2584794c6f77ad654cc74958bc573cfc950ca

Chainlink subscription contract :
https://mumbai.polygonscan.com/address/0x7a1bac17ccc5b313516c5e16fb24f7659aa5ebed

Add VRF consumer contract :
https://mumbai.polygonscan.com/tx/0x65651dd80d754980cc06264b66cd771dff31eab5cda3ccb6465370d6f63adfe6