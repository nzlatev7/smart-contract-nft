// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {MoodNft} from "../src/MoodNft.sol";

contract MintBasicNft is Script {
    string private constant PUG =
        "http://ipfs.io/ipfs/QmYdD4NWtd8cYRbos82HhKJFnuJEEdLGuQNELt41HxQsxT";

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(PUG);
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);
    }
}

contract MintMoodNft is Script {
    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        MoodNft(contractAddress).mintNft();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);
    }
}

contract FlipMoodNft is Script {
    function flipNftOnContract(
        address contractAddress,
        uint256 tokenId
    ) public {
        vm.startBroadcast();
        MoodNft(contractAddress).flipMood(tokenId);
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );

        if (MoodNft(mostRecentlyDeployed).getTokenCounter() == 0) {
            MintMoodNft mintMoodNft = new MintMoodNft();

            mintMoodNft.mintNftOnContract(mostRecentlyDeployed);
        }

        flipNftOnContract(mostRecentlyDeployed, 0);
    }
}
