// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract PoetryNFT is ERC721 {
    uint256 private _nextTokenId;

    constructor() ERC721("PoetryNFT", "PNFT") {}

    mapping(uint256 => string) private _poetry;

    event PoetryPublished(address indexed author, uint256 indexed tokenId, string text);

    function publishPoetry(string memory text) external {
        uint256 tokenId = _nextTokenId;
        _safeMint(msg.sender, tokenId);
        _nextTokenId++;
        _poetry[tokenId] = text;
        emit PoetryPublished(msg.sender, tokenId, text);
    }

    function retrievePoetryText(uint256 tokenId) external view returns (string memory) {
        require(_ownerOf(tokenId) != address(0), "Token doesn't exist");
        return _poetry[tokenId];
    }
}