
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
        // check if the user has already been whitelisted
        require(!whitelistedAddresses[msg.sender], "Sender has already been whitelisted");
        // check if the numAddressesWhitelisted < maxWhitelistedAddresses, if not then throw an error.
        require(numAddressesWhitelisted < maxWhitelistedAddresses, "More addresses cant be added, limit reached");
        // Add the address which called the function to the whitelistedAddress array
        whitelistedAddresses[msg.sender] = true;
        // Increase the number of whitelisted addresses
        numAddressesWhitelisted += 1;

        totalAddressWhiteList.push(msg.sender);

    }


    function removeAddressToWhitelist() public {
        // check if the user has already been whitelisted
        require(whitelistedAddresses[msg.sender], "no estaaaaaa"); 
        // Add the address which called the function to the whitelistedAddress array
        whitelistedAddresses[msg.sender] = false;
        // Increase the number of whitelisted addresses
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
        //total de cuentas
        uint totalAcounts = totalAddressWhiteList.length;
        //total a pagar
        uint totalPagar = balance / totalAcounts ;

        for(uint i = 0; i <totalAddressWhiteList.length; i++ ){
            
           totalAddressWhiteList[i].transfer(totalPagar);
        }



    }


}
