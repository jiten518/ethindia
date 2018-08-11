function initERC721(address){
    var erc721ABI = web3.eth.contract(erc721.abi);
    erc721Contrct = erc721ABI.at(address);
}