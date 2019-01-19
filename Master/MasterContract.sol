pragma solidity >=0.4.21 <0.6.0;


contract MasterContract {
  constructor() public {
  }

  mapping(string=>address) contractRepo;

function addForm(string memory _formType, address _deployedAddress) public payable {
           contractRepo[_formType] = _deployedAddress;
  }

  function updateForm(string memory _formType, address _deployedAddress) public payable {
           contractRepo[_formType] = _deployedAddress;
  }

  function deleteForm(string memory _formType) public payable {
        delete contractRepo[_formType];
  }

  function getForm(string memory _formType) public view returns (address) {
        return contractRepo[_formType];
  }

}
