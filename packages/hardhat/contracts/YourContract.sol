pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract {

  error IncorrectValue();

  struct Position{
    uint8 pos;
    bool isWinner;
    bool priceClaimed;
    uint price;
  }

  address immutable admin;

  mapping(address => mapping(uint8 =>Position)) positions;
  mapping(address => uint8  ) matchId;
  

  constructor() public payable {
    admin = msg.sender;
    
  }

  function StartNewGame(uint bet) public payable {
  if(!(msg.value == bet)) revert IncorrectValue();
    uint8 NewMatchId = matchId[msg.sender] ++;
   
    positions[msg.sender][NewMatchId] = Position(0,false,false,bet);


  }


  function Move(uint8 place) public returns (uint8) {
    uint8 currentmatch = matchId[msg.sender];
    uint8 currentPos = positions[msg.sender][currentmatch].pos;
    if((place ==1) && (currentPos==0 || currentPos==2)){
      positions[msg.sender][currentmatch].pos = place;
    }

    if((place ==2) && (currentPos==0 || currentPos==1)){
      positions[msg.sender][currentmatch].pos = place;
    }

    if((place ==3) && (currentPos==1 || currentPos==2 || currentPos==4)){
      positions[msg.sender][currentmatch].pos = place;
    }

    if((place ==4) && (currentPos==1 || currentPos==2 || currentPos==3)){
      positions[msg.sender][currentmatch].pos = place;
    }

    if((place ==5) && (currentPos==6 || currentPos==3 || currentPos==4)){
      positions[msg.sender][currentmatch].pos = place;
    }

    if((place ==6) && (currentPos==4 || currentPos==3 || currentPos==5)){
      positions[msg.sender][currentmatch].pos = place;
    }

    if((place ==7) && (currentPos==6 || currentPos==5 || currentPos==8)){
      positions[msg.sender][currentmatch].pos = place;
    }

    if((place ==8) && (currentPos==6 || currentPos==5 || currentPos==7)){
      positions[msg.sender][currentmatch].pos = place;
    }

    if((place ==9) && (currentPos==7 || currentPos==8 || currentPos==10)){
      positions[msg.sender][currentmatch].pos = place;
    }

    if((place ==10) && (currentPos==7 || currentPos==8 || currentPos==9)){
      positions[msg.sender][currentmatch].pos = place;
    }

    if((place ==11) && (currentPos==10 || currentPos==12 || currentPos==9)){
      positions[msg.sender][currentmatch].pos = place;
    }

    if((place ==12) && (currentPos==10 || currentPos==9 || currentPos==11)){
      positions[msg.sender][currentmatch].pos = place;
    }

    if((place ==13) && (currentPos==11 || currentPos==12 || currentPos==14)){
      positions[msg.sender][currentmatch].pos = place;
    }

    if((place ==14) && (currentPos==11 || currentPos==12 || currentPos==13)){
      positions[msg.sender][currentmatch].pos = place;
    }

    if((place ==15) && (currentPos==14 || currentPos==13)){
      positions[msg.sender][currentmatch].pos = place;
      positions[msg.sender][currentmatch].isWinner = true;  
    }

    return positions[msg.sender][currentmatch].pos;
    
  }

  function ClaimPrice(uint8 id) public {
    if(positions[msg.sender][id].isWinner){
      require(positions[msg.sender][id].priceClaimed == false,"Already Claimed!");
      positions[msg.sender][id].priceClaimed = true;
      (bool success, ) = msg.sender.call{value: positions[msg.sender][id].price}("");
      require(success, "Transfer failed");  
    }


  }








}
