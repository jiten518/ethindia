var txId = undefined;

function onWeb3Create() {
    initFedResBank();
}
function initFedResBank() {
    var fedResBankABI = web3.eth.contract(fedResSys.abi);
    frsContract = fedResBankABI.at(FRS_CONTRACT_ADDRESS);
    initEvents();
    actionPerform();
}

function initEvents(){
    frsContract.onTransactionCompleted(function(e, data){
        debugger;
        if(err){
            return;
        }
        // if(txId == data)
    })
}
function hideLoader(){
    document.getElementById("loader").style.display = "none";
    document.getElementById("mainDiv").style.display = "block";
}

function showLoader(){
    document.getElementById("loader").style.display = "block";
}
function onPOSScan(selectedDemon, noteId, address){
    frsContract.requestMoney.estimateGas(selectedDemon, noteId, address, function(err,_gas){
        if(err){
          swal("Sorry!", `Unable to calculate gas`, "error");
          hideLoader();
          return;
        }
        frsContract.requestMoney.sendTransaction(selectedDemon, noteId, address, {gas:parseInt(_gas*1.3)}, function (error, data) {
          if(error){
            swal("Sorry!", `Process transaction`, "error");
            hideLoader();
            return;
          }
          txId = data;
        });
    })
}
function printMoney() {
    showLoader();
    var denomination = parseInt($("#denominationForAdd").val());
    var quantity = parseInt($("#quantity").val());
    var _from = web3.eth.accounts[0];
    frsContract.printMoney.estimateGas(denomination, quantity, { from: _from }, function (error, _gas) {
        if (error) {
            showError("printMoney");            
            return;
            //Show sweet alert();
        }
        debugger;
        frsContract.printMoney.sendTransaction(denomination, quantity, { from: _from, gas: parseInt(_gas * 1.3) }, function (error, _gas) {
            if (error) {
                showError("printMoney");            
                return;
                //Show sweet alert();
            }
            txId = _gas;
        });
    });
}

function getTotalMoney(toAddress, callback){
    frsContract.getTotalMoney.call(toAddress, function (error, _gas) {
        if(error){
            callback.onError(error);
            return;
        }
        callback.onSuccess(_gas);
    });
}
function burnMoney() {
    var denomination = parseInt($("#denominationForBurn").val());
    var noteId = parseInt($("#nodeId").val());
    var _from = web3.eth.accounts[0];
    frsContract.printMoney.estimateGas(denomination, noteId, { from: _from }, function (error, _gas) {
        if (error) {
            hideLoader();
            
            return;
            //Show sweet alert();
        }
        debugger;
        frsContract.burnMoney.sendTransaction(denomination, noteId, { from: _from, gas: parseInt(_gas * 1.3) }, function (error, _gas) {
            debugger;
            hideLoader();
            
        });
    });
}

function transferMoney() {
    var denomination = parseInt($("#denominationForTransfer").val());
    var nodeId = parseInt($("#noteIdForTransfer").val());
    var toAddress = parseInt($("#toAddress").val());
    var _from = web3.eth.accounts[0];
    frsContract.printMoney.estimateGas(denomination, nodeId, toAddress, { from: _from }, function (error, _gas) {
        if (error) {
            hideLoader();
            
            return;
            //Show sweet alert();
        }
        debugger;
        frsContract.approveAndTransfer.sendTransaction(denomination, nodeId, toAddress, { from: _from, gas: parseInt(_gas * 1.3) }, function (error, _gas) {
            debugger;
            hideLoader();
            
        });
    });
}

function getDenomination(callback) {
    frsContract.getDenominations.call(function (error, data) {
        if(error){
            callback.onError(error);
            return;
        }
        callback.onSuccess(data);
    });
}


function addUser(){
    showLoader();
    var userAddress =$("#addUserId").val();
    var _from = web3.eth.accounts[0];
    frsContract.addUser.estimateGas(userAddress, { from: _from }, function (error, _gas) {
        if (error) {
            showError("addUser");            
            return;
            //Show sweet alert();
        }
        debugger;
        frsContract.addUser.sendTransaction(userAddress, { from: _from, gas: parseInt(_gas * 1.3) }, function (error, _gas) {
            if (error) {
                showError("addUser");            
                return;
                //Show sweet alert();
            }
            txId = _gas;
        });
    });
}


function checkIfUserExist(){
    showLoader();
    var userAddress =$("#VerifyNewUserId").val();
    frsContract.isUserExists.call(userAddress, function (error, _gas) {
            if (error) {
                showError("addUser");            
                return;
                //Show sweet alert();
            }
            txId = _gas; 
    });
}

