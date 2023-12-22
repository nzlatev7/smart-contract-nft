// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        string memory happySvgImage = vm.readFile("img/happy.svg");
        string memory sadSvgImage = vm.readFile("img/sad.svg");

        string memory happyUri = svgToImageURI(happySvgImage);
        string memory sadUri = svgToImageURI(sadSvgImage);

        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(sadUri, happyUri);
        vm.stopBroadcast();
        return moodNft;
    }

    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        // load the file
        // base64
        // append the data
        // base64 and return it as string

        string memory baseURL = "data:image/svg+xml;base64,";

        // why multiple castings?
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );

        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}
