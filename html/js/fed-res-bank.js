function onWeb3Create() {
    initFedResBank();
}
function initFedResBank() {
    var fedResBankABI = web3.eth.contract(fedResSys.abi);
    frsContract = fedResBankABI.at(FRS_CONTRACT_ADDRESS);
}
function printMoney() {
    var denomination = parseInt($("#denomination").val());
    var quantity = parseInt($("#quantity").val());
    var _from = web3.eth.accounts[0];
    frsContract.printMoney.estimateGas(denomination, quantity, { from: _from }, function (error, _gas) {
        if (error) {
            return;
            //Show sweet alert();
        }
        debugger;
        frsContract.printMoney.sendTransaction(denomination, quantity, { from: _from, gas: parseInt(_gas * 1.3) }, function (error, _gas) {
            debugger;
        });
    });
}

function burnMoney() {
    var denomination = parseInt($("#denominationForBurn").val());
    var noteId = parseInt($("#nodeId").val());
    var _from = web3.eth.accounts[0];
    frsContract.printMoney.estimateGas(denomination, noteId, { from: _from }, function (error, _gas) {
        if (error) {
            return;
            //Show sweet alert();
        }
        debugger;
        frsContract.burnMoney.sendTransaction(denomination, noteId, { from: _from, gas: parseInt(_gas * 1.3) }, function (error, _gas) {
            debugger;
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
            return;
            //Show sweet alert();
        }
        debugger;
        frsContract.approveAndTransfer.sendTransaction(denomination, nodeId, toAddress, { from: _from, gas: parseInt(_gas * 1.3) }, function (error, _gas) {
            debugger;
        });
    });
}

function getDenomination() {
    var _from = web3.eth.accounts[0];
    frsContract.printMoney.estimateGas({ from: _from }, function (error, _gas) {
        if (error) {
            return;
            //Show sweet alert();
        }
        debugger;
        frsContract.getDenominations.sendTransaction({ from: _from, gas: parseInt(_gas * 1.3) }, function (error, _gas) {
            debugger;
        });
    });
}

