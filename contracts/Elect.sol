/* pragma solidity ^0.4.22;

contract Storage {
    function getElectoral() returns (address[]) {}
    function countElectoral() returns (uint) {}
    function getVoterId (address _addr) returns (string) {}
    function checkElectoral (address _addr, string _id) returns (bool) {}
}

contract Elect {
    address storageAddr = 0x097F9EeCc16e93E9fcEE5a7bdE93F0bf01ECF1dC;
    Storage _sto = Storage(storageAddr);
    
    struct Party {
        uint bjp;
        uint con;
        uint jds;
    }
    struct PartyID {
        uint pid;
    }

    address public manager;
    address[] voters;
    mapping (address => PartyID) Verify;
    mapping (uint => Party) Votes;

    constructor() public {3
        manager = msg.sender;
    }

    function checkE(address _addr, string _ID) public returns (bool) {
        return _sto.checkElectoral(_addr, _ID);
    }

    function castVote (uint _cid, uint _pid, string _vid) public non_voters {
      if (checkE(msg.sender, _vid)) {
          voters.push(msg.sender);
          Verify[msg.sender].pid = _pid;

        if (_pid == 1)
            Votes[_cid].bjp++;
        else if (_pid == 2)
            Votes[_cid].con++;
        else if (_pid == 3)
              Votes[_cid].jds++;
      }
    }

    function getVotes (uint cid, uint pid) view public returns (uint) {
      if (pid == 1)
        return (Votes[cid].bjp);
      else if (pid == 2)
        return (Votes[cid].con);
      else if (pid == 3)
        return (Votes[cid].jds);
    }
    
    function getResult (uint cid) view public returns (uint) {
      if (Votes[cid].bjp > Votes[cid].con) {
        if (Votes[cid].bjp > Votes[cid].jds) 
            return 1;
        else 
            return 3;
      } else {
        if (Votes[cid].con > Votes[cid].jds) 
          return 2;
        else 
          return 3;
      }
    }
    
    function verifyVote (address _addr) view public returns (uint) {
      return (Verify[_addr].pid);
    }
    
    function getVoters () view public returns (address[]) {
      return (voters);
    }
    
    modifier non_voters {
      uint flag = 0;
      for(uint i=0; i<voters.length; i++){
        if(voters[i] == msg.sender){
          flag = 1;
          break;
        }
      }
      require(flag == 0);
      _;
    }
}
 */