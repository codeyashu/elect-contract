pragma solidity ^0.4.22;

contract Beta {
    struct Votes {
        uint p1;
        uint p2;
        uint p3;
    }
    
    mapping (uint => Votes) public Constituency;
    uint[] constituencies;

    constructor() public {
        for(uint i=301; i<307; i++) {
            constituencies.push(i);
            Constituency[i] = Votes(0,0,0);
        }
    }
    
    function listConstituencies () view public returns (uint[]) {
        return constituencies;
    }
    
    function castVote (uint _cid, uint _pid) public {
        if (_pid == 1)
            Constituency[_cid].p1++;
        else if (_pid == 2)
            Constituency[_cid].p2++;
        else if (_pid == 3)
            Constituency[_cid].p3++;
    }
    
    function getVotes (uint _cid) view public returns (uint, uint, uint) {
        return (Constituency[_cid].p1, Constituency[_cid].p2, Constituency[_cid].p3);
    }
}