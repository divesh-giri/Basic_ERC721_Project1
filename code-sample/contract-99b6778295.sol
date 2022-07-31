// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.2/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.2/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.7.2/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.7.2/utils/Counters.sol";

contract DGToken is ERC721, ERC721Enumerable, ERC721URIStorage {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 MAX_SUPPLY = 1000;
    uint256 MAX_LIMIT_PER_ADDRESS = 2;

    mapping (address=>uint256) public _nftOwners;

    constructor() ERC721("DGArt", "DGA") {}

    function safeMint(address to, string memory uri) public {   
            uint256 tokenId = _tokenIdCounter.current();
            require(tokenId <= MAX_SUPPLY, "MAX LIMIT REACHED TO MINT TOKENS");
            require(_nftOwners[to]<MAX_LIMIT_PER_ADDRESS, "Cant mint more nfts using this address");
            _tokenIdCounter.increment();
            _safeMint(to, tokenId);
            _setTokenURI(tokenId, uri);
            _nftOwners[to] += 1;
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
