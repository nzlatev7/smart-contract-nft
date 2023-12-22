// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    BasicNft basicNft;
    DeployBasicNft deployBasicNft;

    address bob = makeAddr("bob");
    string private constant PUG =
        "ipfs://QmYdD4NWtd8cYRbos82HhKJFnuJEEdLGuQNELt41HxQsxT";

    function setUp() public {
        deployBasicNft = new DeployBasicNft();
        basicNft = deployBasicNft.run();
    }

    function testNameIsCorrect() public view {
        // stirngs = array of bytes
        // we can not compare arrays?

        // we can loop through the elements but we are lazy
        // we will use hash function (keccak256)
        // keccak256 - param - bytes, return - byte32
        // we can use bytes cast or abi.encodePacked()

        bytes32 expectedName = keccak256(abi.encodePacked("Dogie"));
        bytes32 actualName = keccak256(abi.encodePacked(basicNft.name()));
        assert(expectedName == actualName);
    }

    function testCanMintAndHaveABalance() public {
        uint256 expextedBalance = 1;
        uint256 tokenIndex = 0;

        vm.prank(bob);
        basicNft.mintNft(PUG);

        assert(expextedBalance == basicNft.balanceOf(bob));
        assert(keccak256(abi.encodePacked(PUG)) == keccak256(abi.encodePacked(basicNft.tokenURI(tokenIndex))));
    }
}
