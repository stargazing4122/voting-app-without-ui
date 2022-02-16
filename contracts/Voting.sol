// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.7.0;

contract Voting {
    //estructuta y lista de candidatos
    struct Candidate {
        string name;
        string association;
        uint totalVotes;
    }
    mapping (uint => Candidate) public candidates;

    //votantes
    mapping ( address => bool ) public voters;

    //para asignar un id a candidatos nuevos
    uint private topIdCandidate = 0;

    //modificadores al votar
    modifier onlyHasNoVote () {
        require(voters[msg.sender] == false, 'you have already voted');
        _;
    }

    modifier validCandidate (uint _candidateId) {
        require(_candidateId < topIdCandidate && _candidateId > 0);
        _;
    }

    //eventos
    event Vote(address indexed _voterAddres, uint _candidateId );

    //constructor
    constructor() public {
        _addCandidate('Peter', 'Izquierda');
        _addCandidate('Louis', 'Derecha');
        _addCandidate('Mary', 'Centro');
    }

    //others functions
    function _addCandidate (string memory _candidateName, string memory _candidateAssociation) private {
        topIdCandidate++;
        candidates[topIdCandidate] = Candidate(_candidateName, _candidateAssociation, 0);
    }

    //main function
    function vote ( uint _candidateId ) public onlyHasNoVote validCandidate(_candidateId){
        candidates[_candidateId].totalVotes ++;
        voters[msg.sender] = true;
        emit Vote(msg.sender, _candidateId);

    }




}