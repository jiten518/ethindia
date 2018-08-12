var NETWORK_ID = 72618;
var url = "http://172.16.23.189:8548";
var FRS_CONTRACT_ADDRESS = "0xf7a871d3a0d777c6b0353702fc5d73e497a81e76"

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
function setUserInfo(userId){
    localStorage.userId = userId;
}
function getLoginUser(){
    if(!localStorage.userId){
        setUserInfo('0xba124aadc58ee6b08b548c1c479ee8e588479e00');
    }
    return localStorage.userId;
}
