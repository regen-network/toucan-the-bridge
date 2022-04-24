// Run using:
//   yarn hardhat run scripts / regen - bridge.js--network rinkeby

const hre = require("hardhat");

async function deploy() {
	// Hardhat always runs the compile task when running scripts with its command
	// line interface.
	//
	// If this script is run directly using `node` you may want to call compile
	// manually to make sure everything is compiled
	// await hre.run('compile');

	const [owner, axearBridge, nct] = await ethers.getSigners(); //get the account to deploy the contract
	console.log("OWNER address", owner.address);

	const RegenBridge = await hre.ethers.getContractFactory("RegenBridge");
	const c = await RegenBridge.deploy(owner.address, nct.address, axearBridge.address);

	let receipt = await c.deployed();
	// console.log("receipt", receipt);

	console.log("Regen Bridge Handler deployed to:", c.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
deploy()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error);
		process.exit(1);
	});

// single account:
// owner: 0xA2f702E4756663BD2DA80117A856d7482e51872B
// carbon1: 0x413e867DA34d38874d4db00d9F0B3587Ce35700A

// gnossis owned token: 0xfB60d39F7614BdaFe7EBF5475858bdc591f804Cf
