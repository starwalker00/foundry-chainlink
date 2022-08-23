## RUN SCRIPTS
function deploy {
    forge script script/VRFConsumer.s.sol:Deploy --rpc-url $RPC_URL  --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_KEY -vvvv
}

function setNumber {
    forge script script/VRFConsumer.s.sol:SetNumber --rpc-url $RPC_URL  --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_KEY -vvvv
}

function setRandomNumber {
    forge script script/VRFConsumer.s.sol:SetRandomNumber --rpc-url $RPC_URL  --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_KEY -vvvv
}

function getNumber {
    forge script script/VRFConsumer.s.sol:GetNumber --rpc-url $RPC_URL  --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_KEY -vvvv
}

## RUN TESTS
function test {
    forge test --match-contract VRF*
}

## OTHER
# https://book.getfoundry.sh/forge/deploying#verifying-a-pre-existing-contract
function verify {
    forge verify-contract --chain-id 80001 0xde7B240845e7cd386b79e18bbD7526225243dCCd src/VRFConsumer.sol:VRFConsumer $ETHERSCAN_KEY
}

