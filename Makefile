-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil


build :; forge build

test:
	forge test

install :; forge install cyfrin/foundry-devOps@0.2.2 --no-git && forge install smartcontractkit/chainlink-brownie-contracts@1.1.1 --no-git && forge install foundry-rs/forge-std@1.8.2 --no-git && forge install transmissions11/solmate@v6 --no-git

NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast

deploy:
	@forge script script/DeployBasicNFT.s.sol:DeployBasicNFT $(NETWORK_ARGS)

deploy-anvil:
	@forge script script/DeployBasicNFT.s.sol:DeployBasicNFT --broadcast -vvv

mint:
	@forge script script/Interaction.s.sol:mintBasicNFT $(NETWORK_ARGS) 

deploy-moodNFT:
	@forge script script/DeployMoodNFT.s.sol:DeployMoodNFT $(NETWORK_ARGS)