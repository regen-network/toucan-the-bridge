# Regen - Toucan The Bridge handler

Smart contract implementing required functionality to transfer carbon credits between [Regen Ledger](https://regen.network/) (Cosmos Chain) and [Toucan](https://docs.toucan.earth) (Polygon) registry using [**The Bridge Message Standard**](https://github.com/robert-zaremba/ethamsterdam-the-bridge).
Regen Ledger credits are not Cosmos SDK bank denoms and they don't have a more specific requirements so a traditional token bridge is not applicable.

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
