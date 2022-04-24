// SPDX-License-Identifier:  MPL-2.0

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/security/Pausable.sol";

import "./Ownable.sol";
import "./toucan-contracts/contracts/interfaces/IToucanContractRegistry.sol";
import "./toucan-contracts/contracts/ToucanCarbonOffsets.sol";
import "./axelar/IAxelarGateway.sol";

/**
 * @dev Regen - Toucan TCO2 bridge handler impementing the The Bridge message standard.
 *
 * See README file for more information about the functionality
 */
contract RegenBridge is Ownable, Pausable {
    IToucanContractRegistry public nctoRegistry;
    IAxelarGateway public axelarGateway;

    struct ToucanPayload {
        string recipient;
        address tco2ContractAddress;
        uint256 amount;
        string note;
    }

    /** @dev total amount of tokens burned and signalled for transfer */
    uint256 public totalTransferred;

    /**
     * @dev Initializes contract parameters.
     */
    constructor(
        address owner,
        IToucanContractRegistry _nctoRegistry,
        IAxelarGateway _axelarGateway
    ) Ownable(owner) {
        nctoRegistry = _nctoRegistry;
        axelarGateway = _axelarGateway;
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    /**
     * @dev burns Toucan TCO2 compatible tokens (whitelisted in ncto) and signals a
     * bridge event.
     */
    function bridge(
        string calldata recipient,
        ToucanCarbonOffsets tco2,
        uint256 amount,
        string calldata note
    ) external whenNotPaused {
        require(
            isRegenAddress(bytes(recipient)),
            "recipient must a Regen Ledger account address"
        );
        totalTransferred += amount;

        require(
            nctoRegistry.checkERC20(address(tco2)),
            "contract not part of the Toucan NCT registry"
        );
        tco2.retireFrom(msg.sender, amount);
        ToucanPayload memory p = ToucanPayload(recipient, address(tco2), amount, note);
        axelarGateway.callContract("regen-ledger", "regen_toucan_bridge", abi.encode(p));

        // TODO
        // + burn (needs that functionality from the Toucan side)
    }

    function isRegenAddress(bytes memory recipient) internal pure returns (bool) {
        // verification: checking if recipient starts with "regen1"
        require(recipient.length >= 44, "regen address is at least 44 characters long");
        bytes memory prefix = "regen1";
        for (uint8 i = 0; i < 6; ++i)
            require(prefix[i] == recipient[i], "regen address must start with 'regen1'");
        return true;
    }
}
