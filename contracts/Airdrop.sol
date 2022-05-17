
//SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.6.0;

contract Airdrop {
    uint256 public maxWhitelistedAddresses;


    mapping(address => bool) public whitelistedAddresses;
    uint256 public numAddressesWhitelisted;

    address payable [] public  totalAddressWhiteList; 

    constructor(uint256 _maxWhitelistedAddresses) public {
        maxWhitelistedAddresses = _maxWhitelistedAddresses;
    }


    function addAddressToWhitelist() public {
       
        require(!whitelistedAddresses[msg.sender], "Sender has already been whitelisted");
    
        require(numAddressesWhitelisted < maxWhitelistedAddresses, "More addresses cant be added, limit reached");

        whitelistedAddresses[msg.sender] = true;
    
        numAddressesWhitelisted += 1;

        totalAddressWhiteList.push(msg.sender);

    }
    
    function sendEthers(uint _numETH) public payable {
    
        require(msg.value >= _numETH, "envia mas eth");
        
        msg.sender.transfer(_numETH);
        


    }



    function removeAddressToWhitelist() public {
  
        require(whitelistedAddresses[msg.sender], "no estaaaaaa"); 
      
        whitelistedAddresses[msg.sender] = false;
  
        numAddressesWhitelisted -= 1;
        
        for(uint256 i = 0; i < totalAddressWhiteList.length; i++ ){
            if(totalAddressWhiteList[i]== msg.sender){
                totalAddressWhiteList.pop();
            }


        }
    }


    function addressWhiteList() public view returns(address payable [] memory ){
        return  totalAddressWhiteList;
    }
    

    function airdrop() public payable {
        uint balance = address(this).balance;
    
        uint totalAcounts = totalAddressWhiteList.length;
     
        uint totalPagar = balance / totalAcounts ;

        for(uint i = 0; i <totalAddressWhiteList.length; i++ ){
            
           totalAddressWhiteList[i].transfer(totalPagar);
        }



    }


}
