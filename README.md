# Regen - Toucan The Bridge handler

Smart contracts for The Bridge standard for moving assets between [Toucan](https://docs.toucan.earth) (Polygon) and [Regen Ledger](https://regen.network/) (Cosmos Chain).

## Summary

Reference implementation of the The Bridge Message standard.
We use bridge to pass messages between Polygon and Regen Ledger using Axelar chain as a bridge example.

The use case is to use bridge to move tokens between registry.

## Functionality

- burning TCO2 whitelisted tokens and issuing bridge events.

## Dependencies

- node > 16.0
- pnpm > 6.20

## Setup

```shell
git submodule sync
pnpm install
pnpm husky install
```

## Hardhat usage

```shell
pnpm hardhat accounts
pnpm hardhat compile
pnpm hardhat clean
pnpm hardhat test
pnpm hardhat node
node scripts/sample-script.js
pnpm hardhat help
```

## License

See the [LICENSE](./LICENSE) file.
