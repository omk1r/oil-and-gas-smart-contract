// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract OilAndGas{
        address public owner;
        struct OilWell{
            string name;
            address operator;
            uint256 production;
        }

        mapping(string => OilWell) public wells;
        event changeOperator(string indexed _wellName,address indexed _operator);
        event changeProduction(string indexed _wellName,uint256 indexed _production);

        constructor() {
            owner = msg.sender;
        }

    function createWell(string memory _wellName) public{
        wells[_wellName] = OilWell(_wellName,msg.sender,0);
    }
        
    function updateOperator(string memory _wellName,address _operator) public{
        require(msg.sender==owner,"only ownner can change the operator");
        wells[_wellName].operator = _operator;
        emit changeOperator( _wellName,_operator);
    }

    function updateProduction(string memory _wellName,uint256 _production) public {
        require(msg.sender==wells[_wellName].operator,"sender must be operator");
        wells[_wellName].production = _production;
        emit changeProduction(_wellName,_production);
    }

    function checkWell(string memory _wellname) public view returns(string memory,address,uint256){
        return(wells[_wellname].name,wells[_wellname].operator,wells[_wellname].production);
    }
}