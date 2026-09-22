// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {MoodNFT} from "../src/MoodNFT.sol";
import {Script, console} from "../lib/forge-std/src/Script.sol";
import {Base64} from "../lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    MoodNFT moodNFT;

    function run() external returns (MoodNFT) {
        string memory sadSvg = vm.readFile("./img/Sad.svg");
        string memory happySvg = vm.readFile("./img/Happy.svg");

        string memory sadSvgImageUri = svgToImageURI(sadSvg);
        string memory happySvgImageUri = svgToImageURI(happySvg);

        vm.startBroadcast();
        moodNFT = new MoodNFT(sadSvgImageUri, happySvgImageUri);
        vm.stopBroadcast();

        return moodNFT;
    }

    function svgToImageURI(string memory svg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));

        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}

// You can create script to mint the nft and also a script to flipMood....just for interractions other than cast