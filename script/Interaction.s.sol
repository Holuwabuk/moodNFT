// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import {BasicNFT} from "../src/BasicNFT.sol";
import {Script} from "../lib/forge-std/src/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";

contract mintBasicNFT is Script {
    string public constant PUG = "ipfs://bafkreigp76b37nlj6c5noqnikovrm3rep5ubglcjbh5jzyeqdgi3mtajgm";

    function run() external {
       address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("BasicNFT", block.chainid); //we always want to use the most recently deployed, hence install DevOps using  forge install ChainAccelOrg/foundry-devops --no-git
       mintNFTOnContract(mostRecentlyDeployed);
    }

    function mintNFTOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNFT(contractAddress).mintNFT(PUG);
        vm.stopBroadcast();
    }

}

//This interraction contract is to mint, should in case you don't want to use "cast" from the terminal
//upload image to pinata, copy the cid and use it to write the metadata using moxila...copy the data on notepad,upload to pinata....the cid is what you'd use in your PUG
