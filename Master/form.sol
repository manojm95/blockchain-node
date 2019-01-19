pragma solidity >=0.4.21 <0.6.0;


contract FactoryFormb {

  constructor() public {
  }


  struct servicingAgencyContractStruct {
      ContractA[] contracts;
      bool exists;
  }

   struct requestingAgencyContractStruct {
      ContractA[] contracts;
      bool exists;
  }

  mapping(string=>servicingAgencyContractStruct) servicingAgencyContractsMap; 
  mapping(string=>requestingAgencyContractStruct) requestingAgencyContractsMap; 


  function createAgreement(string memory _reqAgencyName,
    string memory _reqAgencyAddress,
    string memory _serAgencyName,
    string memory _serAgecyAddress,
    string memory _serAgencyTrackingNo,
    string memory _actionGTC,
    uint _agreementStartDate,
    uint _agreementEndDate,
    bool _isrecurringAgreement,
    string memory _agreementType,
    bool _isadvancePaymentAllowed,
    uint _estimatedAmount) public returns (ContractA) {

      ContractA contractA = new ContractA(_reqAgencyName, _reqAgencyAddress, _serAgencyName, _serAgecyAddress, _serAgencyTrackingNo,
                                           _actionGTC, _agreementStartDate, _agreementEndDate, _isrecurringAgreement, _agreementType,
                                           _isadvancePaymentAllowed, _estimatedAmount, msg.sender);
      
      //Adding contract info to service agency map
      if(servicingAgencyContractsMap[_reqAgencyName].exists){
          servicingAgencyContractsMap[_reqAgencyName].contracts.push(contractA);
      } else{
          ContractA[]  memory contTemp = new ContractA[](1);
          contTemp[0] = contractA;
          servicingAgencyContractStruct memory tempStruct = servicingAgencyContractStruct({
            contracts: contTemp;
            exists: true;
          })
          servicingAgencyContractsMap[_reqAgencyName] = tempStruct;
      }
      
      //Adding contract info to request agency map
      if(requestingAgencyContractsMap[_reqAgencyName].exists){
          requestingAgencyContractsMap[_reqAgencyName].contracts.push(contractA);
      } else{
          ContractA[]  memory contTemp = new ContractA[](1);
          contTemp[0] = contractA;
          requestingAgencyContractStruct memory tempStruct = requestingAgencyContractStruct({
            contracts: contTemp;
            exists: true;
          })
          requestingAgencyContractsMap[_reqAgencyName] = tempStruct;
      }
    
    }


}

contract FormB {

  //contract params
    string reqAgencyName;
    string reqAgencyAddress;
    string serAgencyName;
    string serAgecyAddress;
    string serAgencyTrackingNo;
    string actionGTC;
    uint agreementStartDate;
    uint agreementEndDate;
    bool isrecurringAgreement;
    string agreementType;
    bool isadvancePaymentAllowed;
    uint estimatedAmount;

    //Authorized address details
    address requestingAgencyAddress;
    address servicingAgencyAddress;

    //approval details
    bool approval1Acquired;
    bool approval2Acquired;

    //contract stage variables

    //sa -> servicingAgency Queue; ra -> requestingAgency Queue
    string contractQueue = 'sa';

    //struct to record amendments
    struct AgreementAmendStruct {
    string reqAgencyName;
    string reqAgencyAddress;
    string serAgencyName;
    string serAgecyAddress;
    string serAgencyTrackingNo;
    string actionGTC;
    uint agreementStartDate;
    uint agreementEndDate;
    bool isrecurringAgreement;
    string agreementType;
    bool isadvancePaymentAllowed;
    uint estimatedAmount;
  }

  //ammendment array
  AgreementAmendStruct[] agreementAmendArray;



  constructor(string memory _reqAgencyName,string memory _reqAgencyAddress,string memory _serAgencyName,
              string memory _serAgecyAddress, string memory _serAgencyTrackingNo, string memory _actionGTC, 
              uint _agreementStartDate, uint _agreementEndDate, bool _isrecurringAgreement, 
              string memory _agreementType, bool _isadvancePaymentAllowed, uint _estimatedAmount, address _reqAddress) {
      
        reqAgencyName = _reqAgencyName;
        reqAgencyAddress = _reqAgencyAddress;
        serAgencyName = _serAgencyName;
        serAgecyAddress = _serAgecyAddress;
        serAgencyTrackingNo = _serAgencyTrackingNo;
        actionGTC = _actionGTC;
        agreementStartDate = _agreementStartDate;
        agreementEndDate = _agreementEndDate;
        isrecurringAgreement = _isrecurringAgreement;
        agreementType = _agreementType;
        isadvancePaymentAllowed = _isadvancePaymentAllowed;
        estimatedAmount = _estimatedAmount;
        requestingAgencyAddress = _reqAddress;
        servicingAgencyAddress = 0x0000000000000000000000000000000000000000;
  }

  function addApproval(uint approvalNo) public payable {
    if(approvalNo == 1){
      approval1Acquired = true;
    } else if(approvalNo == 2) {
      approval2Acquired = true;
    }
  }

  function amendFromServicingAgency(uint amendAmount) public payable {
       require( contractQueue == 'sa');
       estimatedAmount = amendAmount;
       AgreementAmendStruct memory amendTemp = AgreementAmendStruct({

       })
       contractQueue = 'ra';
  }

   modifier restricted() {
        require(msg.sender == requestingAgencyAddress);
        _;
    }

}
