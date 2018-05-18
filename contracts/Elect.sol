pragma solidity ^0.4.22;

contract Storage {
    function getElectoral() returns (address[]) {}
    function getElectoralCount() returns (uint) {}
    function getVoterId (address _addr) returns (string) {}
    function checkElectoral (address _addr, string _vid) returns (bool) {}
}

contract Elect {
    address storageAddr = 0x58337Fb6817910542e5D1fEe1aAe257cc8b27855;
    Storage _sto = Storage(storageAddr);

    address manager;

    struct Votes {
        uint p1;
        uint p2;
        uint p3;
    }
    
    struct Party {
        uint pid;
    }
    
    struct Seats {
        uint p1;
        uint p2;
        uint p3;
    }
    
    Seats Result;

    mapping (uint => Votes) Constituency;
    uint[] constituencies;

    mapping (address => Party) Verify;
    address[] voters;
    
    constructor () public {
        manager = msg.sender;
        for(uint i=301; i<310; i++) {
            constituencies.push(i);
            Constituency[i] = Votes(0,0,0);
        }
    }

    function checkE (address _addr, string _vid) public returns (bool) {
        return _sto.checkElectoral(_addr, _vid);
    }
    
    function getManager () view public returns (address) {
        return manager;
    }
    
    function getConstituencies () view public returns (uint[]) {
        return constituencies;
    }
        
    function getConstituencyCount () view public returns (uint count) {
        return constituencies.length;
    }
    
    function castVote (uint _cid, uint _pid, string _vid) public non_voters {
        if (checkE(msg.sender, _vid)) {
            voters.push(msg.sender);
            Verify[msg.sender].pid = _pid;
            if (_pid == 1)
                Constituency[_cid].p1++;
            else if (_pid == 2)
                Constituency[_cid].p2++;
            else if (_pid == 3)
                Constituency[_cid].p3++;
        }
    }
    
    function verifyVote (address _addr) view public returns (uint) {
      return (Verify[_addr].pid);
    }
    
    function getVoters () view public returns (address[]) {
      return (voters);
    }
    
    function getVotes (uint _cid) view public returns (uint p1, uint p2, uint p3) {
        return (Constituency[_cid].p1, Constituency[_cid].p2, Constituency[_cid].p3);
    }
    
    function findResults () public {
        Result.p1 = 0;
        Result.p2 = 0;
        Result.p3 = 0;
        for(uint i=301; i<310; i++) {
            if((Constituency[i].p1 == Constituency[i].p2) && (Constituency[i].p2 == Constituency[i].p3))
                continue;
            else if((Constituency[i].p1 > Constituency[i].p2) && (Constituency[i].p1 > Constituency[i].p3))
                Result.p1++;
            else if((Constituency[i].p2 > Constituency[i].p1) && (Constituency[i].p2 > Constituency[i].p3))
                Result.p2++;
            else if((Constituency[i].p3 > Constituency[i].p1) && (Constituency[i].p3 > Constituency[i].p2))
                Result.p3++;
        }
    }
    
    function getResults () view public returns (uint p1, uint p2, uint p3) {
        return (Result.p1, Result.p2, Result.p3);
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