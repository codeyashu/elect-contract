// Storing Eth Address and its Voter ID

pragma solidity ^0.4.22;

contract Storage {
    
    struct Voter {
        string voterId;
        // bool status;
    }
    
    address[] ElectoralAcc;

    mapping (address => Voter) Electoral;
    
    function registerOnce (address _addr, string _id) public onlyOnce(_addr) {
        Electoral[_addr].voterId = _id;
        ElectoralAcc.push(_addr);
    }

    function registerAgain (address _addr, string _id) public {
        Electoral[_addr].voterId = _id;
        ElectoralAcc.push(_addr);
    }

    function deleteVoter (address _addr) public {
        delete Electoral[_addr];
    }

    function getElectoral() view public returns (address[]) {
        return ElectoralAcc;
    }
    
    function countElectoral() view public returns (uint) {
        return ElectoralAcc.length;
    }
    
    function getVoterId (address _addr) view public returns (string) {
        return (Electoral[_addr].voterId);
    }
    
    function checkElectoral (address _addr, string _id) view public returns (bool) {
        if (keccak256(Electoral[_addr].voterId) == keccak256(_id)) {
            return true;
        }
        return false;
    }

    modifier onlyOnce(address _addr) {
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
}