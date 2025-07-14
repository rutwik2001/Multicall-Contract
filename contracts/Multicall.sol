// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

/// @title Multicall Contract
/// @notice Enables batch read-only calls and native token balance aggregation

contract Multicall {
    /// @notice Struct representing a single contract call
    /// @param target The address of the contract to call
    /// @param callData The encoded function call data
    struct Call {
        address target;
        bytes callData;
    }

    /// @notice Aggregates multiple contract calls and returns the results along with the caller's balance
    /// @param _address The address to check native token balance for
    /// @param calls Array of Call structs to be executed
    /// @return blockNumber Current block number
    /// @return returnData Array of return data from each call
    /// @return balance Native token balance of the specified address
    function aggregate(address _address, Call[] calldata calls) 
        public 
        view 
        returns (
            uint256 blockNumber,
            bytes[] memory returnData,
            uint256 balance
        ) 
    {
        blockNumber = block.number; // Capture current block number
        uint256 length = calls.length;
        returnData = new bytes[](length);
        balance = _address.balance; // Get native token balance (e.g. ETH, MATIC, ZETA)

        for (uint256 i = 0; i < length;) {
            // Perform a staticcall to each target with the provided calldata
            (bool success, bytes memory ret) = calls[i].target.staticcall(calls[i].callData);
            require(success, "Multicall: call failed");
            returnData[i] = ret;
            unchecked { ++i; } // Gas-efficient increment
        }
    }

    /// @notice Fetches the native token balances of multiple addresses
    /// @param _addresses Array of addresses to check balances for
    /// @return balances Array of native token balances corresponding to each address
    function getBalances(address[] calldata _addresses) 
        public 
        view 
        returns (uint256[] memory balances) 
    {
        uint256 length = _addresses.length;
        balances = new uint256[](length);

        for (uint256 i = 0; i < length;) {
            balances[i] = _addresses[i].balance; // Get native balance for each address
            unchecked { ++i; }
        }
    }

    /// @notice Aggregates multiple contract calls (no balance fetching)
    /// @dev This is a simplified version of `aggregate` for multiple calls without address balance
    /// @param calls Array of Call structs to be executed
    /// @return blockNumber Current block number
    /// @return returnData Array of return data from each call
    function aggregateMultiAddress(Call[] calldata calls) 
        public 
        view 
        returns (
            uint256 blockNumber,
            bytes[] memory returnData
        ) 
    {
        blockNumber = block.number;
        uint256 length = calls.length;
        returnData = new bytes[](length);

        for (uint256 i = 0; i < length;) {
            (bool success, bytes memory ret) = calls[i].target.staticcall(calls[i].callData);
            require(success, "Multicall: call failed");
            returnData[i] = ret;
            unchecked { ++i; }
        }
    }
}
