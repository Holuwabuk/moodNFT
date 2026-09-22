//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {ERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Base64} from "../lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    //errors
    error MoodNFT__CantFlipMoodIfNotOwner();

    uint256 private s_tokenCounter;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }
    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(string memory sadSvgImageUri, string memory happySvgImageUri) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_happySvgImageUri = happySvgImageUri;
        s_sadSvgImageUri = sadSvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY; //defaulting their mood to being happy
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        //only wants the NFT owner to be able to change the mood
        if (!_isAuthorized(_ownerOf(tokenId), msg.sender, tokenId)) {
            revert MoodNFT__CantFlipMoodIfNotOwner();
        }
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageURI;

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happySvgImageUri;
        } else {
            imageURI = s_sadSvgImageUri;
        }

        return string( //Can use concat
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"moodNFT","description":"An NFT that reflects the owners mood","image":"',
                            imageURI,
                            '","attributes":[{"trait_type":"moodiness","value":"100"}]}'
                        )
                    )
                )
            )
        );
    }
}


// Addr: 0x41AaF781A0ef6250CD400Ea52d799105E558D9C1
//to mint without mint script:  cast send 0x41AaF781A0ef6250CD400Ea52d799105E558D9C1 "mintNft()" --private-key $PRIVATE_KEY --rpc-url $SEPOLIA_RPC_URL
//to flipmood:  cast send 0x41AaF781A0ef6250CD400Ea52d799105E558D9C1 "flipMood(uint256 tokenId)" 0 --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY
