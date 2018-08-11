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
    frsContract.printMoney.estimateGas(denomination, quantity, {from:_from}, function(error, _gas){
        if(error){
            //Show sweet alert();
        }
        frsContract.printMoney.sendTransaction(denomination, quantity, {from:_from, gas:parseInt(_gas*1.3)}, function(error, _gas){
            debugger;
        });
    });
}

