function onWeb3Create(){
    initFedResBank();
}
function initFedResBank(){
    var fedResBankABI = SOPweb3.eth.contract(fedResSys.abi);
    frsContract = fedResBankABI.at(FRS_CONTRACT_ADDRESS);
}
function printMoney(){
    frsContract.printMoney.estimateGas(rid, buyerID, function(error, _gas){
        
    });

}

