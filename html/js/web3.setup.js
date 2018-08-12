var NETWORK_ID = 72618;
var url = "http://172.16.23.189:8548";
var FRS_CONTRACT_ADDRESS = "0xeecb53650cadd14a1421bb6e87fd31fa908ce245";//"0x78ED84c6cee74158D3Ba3692d3fc921b06Ca46f5"

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
    //localStorage.userId = userId;
    localStorage.setItem("userId", userId);    
}
function getLoginUser(){
    if(!localStorage.userId){
        setUserInfo('0xba124aadc58ee6b08b548c1c479ee8e588479e00');
    }
    return localStorage.getItem("userId");
}
