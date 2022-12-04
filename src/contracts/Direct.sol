// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

import "./DCStorage.sol";
import "./safemath.sol";
import "./Organization.sol";

contract Direct is Membership{

  string public name = "Crypto Box Direct";
  uint public fileCount = 0;

  mapping(uint => File) public directfiles;

  mapping(address => uint) public addressToFileIds;
  
  struct DirectFile{
    uint fileId;
    string fileHash;
    uint fileSize;
    string fileType;
    string fileName;
    string fileDescription;
    uint uploadTime;
    address payable uploader;
    address reciever;
    bool isOneTimeLink;
  }

  event FileUploaded(
    uint fileId,
    string fileHash,
    uint fileSize,
    string fileType,
    string fileName,
    string fileDescription,
    uint uploadTime,
    address payable uploader,
    address reciever,
    bool isOneTimeLink,
  );

  constructor() public {
  }

  function uploadFile(string memory _fileHash, uint _fileSize, string memory _fileType, string memory _fileName, string memory _fileDescription, address _reciever, bool _isOneTimeLink) public {
    require(bytes(_fileHash).length > 0);
    require(bytes(_fileType).length > 0);
    require(bytes(_fileName).length > 0);
    require(bytes(_fileDescription).length > 0);
    require(msg.sender != address(0));
    require(_fileSize > 0);
    require(bytes(_reciever) > 0);
    files[fileCount] = File(fileCount, _fileHash, _fileSize, _fileType, _fileName, _fileDescription, now, msg.sender, _reciever, _isOneTimeLink);
    addressToFileIds[_reciever].push(fileCount);
    fileCount++;
    emit FileUploaded(fileCount, _fileHash, _fileSize, _fileType, _fileName, _fileDescription, now, msg.sender, _reciever, _isOneTimeLink);
  }
  
}


