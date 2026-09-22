// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {BasicNFT} from "../../src/BasicNFT.sol";
import {Test} from "../../lib/forge-std/src/Test.sol";
import {DeployBasicNFT} from "../../script/DeployBasicNFT.s.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT public deployer; //Declaring the script
    BasicNFT public basicNFT; //Declaring the main contract
    address public USER = makeAddr("user");
    string public constant PUG = "ipfs://bafkreihdpkml2wi3qn3hmf4mut23chh3ks7eeng353agc4m2emefaqjksq";

    function setUp() public {
        deployer = new DeployBasicNFT(); //to test the script itself
        basicNFT = deployer.run();
    }

    function testNameIsCorrect() public view {
        // You can simply have assertEq (basicNFT.name(),"Dogie");                basicNFT.name() helps retrieve the name passed in the constructor
        string memory expectedName = "Dogie";
        string memory actualName = basicNFT.name();
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName))); //You cannot compare strings to strings with ==,hence hashing to bytes using keccak....After that, you can use assert and == or use assertEq with ,
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNFT.mintNFT(PUG);

        assert(basicNFT.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(PUG)) == keccak256(abi.encodePacked(basicNFT.tokenURI(0))));
    }
}
