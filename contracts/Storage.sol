// Storing Ethereum Address and its Voter ID

pragma solidity ^0.4.22;

contract Storage {
    address manager;
    
    struct Voter {
        string voterId;
    }
    
    mapping (address => Voter) Electoral;
    address[] ElectoralAcc;
    
    string[] VoterAcc;

    constructor () public {
        manager = msg.sender;
    }

    function getManager () view public returns (address) {
        return manager;
    }
    
    function registerOnce (address _addr, string _vid) public oneAddress(_addr) oneVoterId(_vid) {
        ElectoralAcc.push(_addr);
        VoterAcc.push(_vid);
        Electoral[_addr].voterId = _vid;
    }
    
    function registerAgain (address _addr, string _vid) public {
        ElectoralAcc.push(_addr);
        VoterAcc.push(_vid);
        Electoral[_addr].voterId = _vid;
    }
    
    function deleteVoter (address _addr) public {
        delete Electoral[_addr];
    }
    
    function getElectoral () view public returns (address[]) {
        return ElectoralAcc;
    }

    function getElectoralCount () view public returns (uint) {
        return ElectoralAcc.length;
    }
    
    function getVoterId (address _addr) view public returns (string) {
        return (Electoral[_addr].voterId);
    }
    
    function checkElectoral (address _addr, string _vid) view public returns (bool) {
        if (keccak256(abi.encodePacked(Electoral[_addr].voterId)) == keccak256(abi.encodePacked(_vid))) {
            return true;
        }
        return false;
    }

    modifier oneAddress (address _addr) {
        uint flag = 0;
        for (uint i = 0; i < ElectoralAcc.length; i++) {
            if (ElectoralAcc[i] == _addr) {
                flag = 1;
                break;
            }
        }
        require(flag == 0);
        _;
    }
    
    modifier oneVoterId (string _vid) {
        uint flag = 0;
        for (uint i = 0; i < VoterAcc.length; i++) {
            if (keccak256(abi.encodePacked(VoterAcc[i])) == keccak256(abi.encodePacked(_vid))) {
                flag = 1;
                break;
            }
        }
        require(flag == 0);
        _;
    }
}