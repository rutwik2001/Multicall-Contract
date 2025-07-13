// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract Multicall {
    struct Call {
        address target;
        bytes callData;
    }

    function aggregate(address _address, Call[] calldata calls) public view returns (
        uint256 blockNumber,
        bytes[] memory returnData,
        uint256 balance
    ) {
        blockNumber = block.number;
        uint256 length = calls.length;
        returnData = new bytes[](length);
        balance = _address.balance;
        for (uint256 i = 0; i < length;) {
            (bool success, bytes memory ret) = calls[i].target.staticcall(calls[i].callData);
            require(success, "Multicall: call failed");
            returnData[i] = ret;
            unchecked { ++i; }
        }
    }

    function getBalances(address[] calldata _addresses) public view returns (uint256[] memory balances) {
        uint256 length = _addresses.length;
        balances = new uint256[](length);
        for (uint256 i = 0; i < length;) {
            balances[i] = _addresses[i].balance;
            unchecked { ++i; }
        }
    }

    function aggregateMultiAddress(Call[] calldata calls) public view returns (
        uint256 blockNumber,
        bytes[] memory returnData
    ) {
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
