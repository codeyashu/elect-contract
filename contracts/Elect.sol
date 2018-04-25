pragma solidity ^0.4.22;

contract vote {
    address public manager;
    address[] voters;
    uint[10] public c101;
    
    constructor() public {
        manager = msg.sender;
    }
    
    function cast_vote(uint id) public non_voters {
        c101[id]++;
        voters.push(msg.sender);
    }

    function pickWinner() public only_manager view returns (uint) {
        uint max;
        uint winner;
        for(uint i=0; i<c101.length; i++){
            if(c101[i] > max){
                max = c101[i];
                winner = i;
            }
        }
        return winner;
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
    
    modifier only_voters {
        uint flag = 0;
        for(uint i=0; i<voters.length; i++){
            if(voters[i] == msg.sender){
                flag = 1;
                break;
            }
        }
        require(flag == 1);
        _;
    }
    
    modifier only_manager {
        require(msg.sender == manager);
        _;
    }
}
