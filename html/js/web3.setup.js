var NETWORK_ID = 72618;
var url = "http://172.16.23.189:8548";
var FRS_CONTRACT_ADDRESS = "0x93c71896a417a29093b8f2afc5d37defeb23e340"

if (window.Web3 !== 'undefined') {
    web3 = new Web3(web3.currentProvider);
}else{
    web3 = new Web3(new Web3.providers.HttpProvider(url));
}
web3.version.getNetwork(function(err, networkId){
    networkId = parseInt(networkId);
    switch(networkId){
        case NETWORK_ID:
            onWeb3Create();
            break;
        default:
            alert("Unable to connect to network, please check your node.");
    }
});

function getLoginUser(){
    return "0xba124aadc58ee6b08b548c1c479ee8e588479e00";
}
