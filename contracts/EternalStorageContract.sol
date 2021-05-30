//SPDX-License-Identifier: MIT
pragma solidity 0.8.1;

contract EternalStorage {
    mapping(bytes32 => uint256) UIntStorage;

    function getUintValue(bytes32 record) public view returns (uint256) {
        return UIntStorage[record];
    }

    function setUintValue(bytes32 record, uint256 value) public {
        UIntStorage[record] = value;
    }

    mapping(bytes32 => bool) BooleanStorage;

    function getBooleanValue(bytes32 record) public view returns (bool) {
        return BooleanStorage[record];
    }

    function setBooleanValue(bytes32 record, bool value) public {
        BooleanStorage[record] = value;
    }
}

library ballotLib {
    function getNumberOfVotes(address _eternalStorage)
        public
        view
        returns (uint256)
    {
        return EternalStorage(_eternalStorage).getUintValue(keccak256("votes"));
    }

    function setVoteCount(address _eternalStorage, uint256 _voteCount) public {
        EternalStorage(_eternalStorage).setUintValue(
            keccak256("votes"),
            _voteCount
        );
    }
}

contract Ballot {
    address public owner;
    bool public paused;

    using ballotLib for address;
    address eternalStorage;

    constructor(address _eternalStorage) {
        eternalStorage = _eternalStorage;
        owner = msg.sender;
    }

    function setPaused(bool _paused) public {
        require(msg.sender == owner, "You are not the owner");
        paused = _paused;
    }

    function getNumberOfVotes() public view returns (uint256) {
        return eternalStorage.getNumberOfVotes();
    }

    function vote() public {
        eternalStorage.setVoteCount(eternalStorage.getNumberOfVotes() + 1);
    }
}
