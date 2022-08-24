## RUN SCRIPTS
function VRFdeploy {
    forge script script/VRFConsumer.s.sol:Deploy --rpc-url $RPC_URL  --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_KEY -vvvv
}

function VRFsetNumber {
    forge script script/VRFConsumer.s.sol:SetNumber --rpc-url $RPC_URL  --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_KEY -vvvv
}

function VRFsetRandomNumber {
    forge script script/VRFConsumer.s.sol:SetRandomNumber --rpc-url $RPC_URL  --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_KEY -vvvv
}

function VRFgetNumber {
    forge script script/VRFConsumer.s.sol:GetNumber --rpc-url $RPC_URL  --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_KEY -vvvv
}

## RUN TESTS
function VRFtest {
    forge test --match-contract VRF*
}

## OTHER
# https://book.getfoundry.sh/forge/deploying#verifying-a-pre-existing-contract
function verify {
    forge verify-contract --chain-id 80001 0xde7B240845e7cd386b79e18bbD7526225243dCCd src/VRFConsumer.sol:VRFConsumer $ETHERSCAN_KEY
}

