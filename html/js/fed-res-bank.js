function onWeb3Create(){
    initFedResBank();
}
function initFedResBank(){
    var fedResBankABI = web3.eth.contract(fedResSys.abi);
    frsContract = fedResBankABI.at(FRS_CONTRACT_ADDRESS);
}
function printMoney(){
    var denomination = parseInt($("#denomination").val());
    var quantity = parseInt($("#quantity").val());
    var _from = web3.eth.accounts[0];
    frsContract.printMoney.sendTransaction(denomination, quantity, {from:_from}, function(error, _gas){
        debugger;
    });

}

