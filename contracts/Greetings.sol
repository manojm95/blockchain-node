pragma solidity >=0.4.21 <0.6.0;


contract Greetings {

  string greet;

  constructor() public {
  }

  function setGreeting(string memory greet2) public payable {
        greet = greet2;
  }

  function getGreeting() public view returns(string memory){
    return greet;
  }

}
