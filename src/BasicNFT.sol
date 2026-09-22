//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;
import {ERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToUri;
    string public tokenUri;

    constructor() ERC721("Dogie", "DOG") {
        // can do  ERC721 ("BasicNFT", "BNFT")
        s_tokenCounter = 0;
    }

    function mintNFT(string memory tokenUri) public {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        // return "ipfs://bafkreihdpkml2wi3qn3hmf4mut23chh3ks7eeng353agc4m2emefaqjks";   or for easy access without ipfs node "https://ipfs.io/bafkreihdpkml2wi3qn3hmf4mut23chh3ks7eeng353agc4m2emefaqjksq";    brave browser comes with a built-in ipfs node but for chrome, you download ipfs broswer to run a local node on your comp,cause not all browsers can access the node normally
        return s_tokenIdToUri[tokenId];
    }
}
