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
