// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract LeaderboardManager is Ownable {
    struct Builder {
        address builderAddress;
        string username;
        uint256 score;
    }

    mapping(address => Builder) public builders;
    address[] public builderAddresses;

    constructor() Ownable(msg.sender) {}

    function addOrUpdateBuilder(address _builder, string memory _username, uint256 _score) public onlyOwner {
        if (builders[_builder].builderAddress == address(0)) {
            builders[_builder] = Builder(_builder, _username, _score);
            builderAddresses.push(_builder);
        } else {
            builders[_builder].score = _score;
        }
    }

    function getBuilder(address _builder) public view returns (Builder memory) {
        return builders[_builder];
    }

    function getAllBuilders() public view returns (Builder[] memory) {
        Builder[] memory result = new Builder[](builderAddresses.length);
        for (uint i = 0; i < builderAddresses.length; i++) {
            result[i] = builders[builderAddresses[i]];
        }
        return result;
    }

    function getTopBuilder() public view returns (Builder memory) {
        Builder memory top;
        for (uint i = 0; i < builderAddresses.length; i++) {
            Builder memory current = builders[builderAddresses[i]];
            if (current.score > top.score) {
                top = current;
            }
        }
        return top;
    }
}
