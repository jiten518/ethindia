pragma solidity ^0.4.18;
interface  IERC721 {
   function name()external view returns (string);
   function symbol()external view returns (string);
   function totalSupply()external view returns (uint256);
   function balanceOf(address _owner)external view returns (uint);

   // Functions that define ownership
   function ownerOf(uint256 _tokenId)external view returns (address);
   function approve(address _to, uint256 _tokenId)external;
   function takeOwnership(uint256 _tokenId)external;
   function transfer(address _to, uint256 _tokenId)external;
   function transferFrom(address _from, address _to, uint _tokenId)public;
//    function tokenOfOwnerByIndex(address _owner, uint256 _index)external view returns (uint tokenId);

   // Token metadata
//    function tokenMetadata(uint256 _tokenId) external view  returns (string infoUrl);

   // Events
   event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
   event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);
}