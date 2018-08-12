function initERC721(address){
    var erc721ABI = web3.eth.contract(erc721.abi);
    erc721Contrct = erc721ABI.at(address);
}

function getNotes(userId, callback){
    erc721Contrct.getNotes.call(userId, function(e, data){
        if(e){
            callback.onError(e);
            return;
        }
        callback.onSuccess(data);
    })
}

function approveAndtrasfer(noteId, _to){
    debugger;
    erc721Contrct.approveAndTransfer.estimateGas(noteId, _to, function(e, _gas){
        if(e){
            swal("Error","Unable to estgas","error");
            return;
        }
        erc721Contrct.approveAndTransfer(noteId, _to, function(e, data){
            debugger;
        });

    })
}