// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// when we launch this contract
// it represents the collection of Dogies
contract BasicNft is ERC721 {
    uint256 private s_tokenCounter;

    // for 1 we receive "QmbGfJ8gsCczze1zYZkCcz9r8VBeRfYmdJCDZC5Sp5UzoP"
    mapping(uint256 => string) private s_tokenIdToUri;

    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0;
    }

    // external or public
    function mintNft(string memory tokenUri) external {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenIdToUri[tokenId];
    }

    /** View Functions */

    function getTokenCounter() external view returns (uint256) {
        return s_tokenCounter;
    }
}
