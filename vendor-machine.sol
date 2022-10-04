
pragma solidity ^0.8.17;

contract VendingMachine {
    address public owner;
    mapping (address => uint) public donutBalances;
 
    constructor(uint initialDonutAmmount){
        //eth address
        owner = msg.sender;
        donutBalances[address(this)] = initialDonutAmmount;        
    }

    function getVendingMachineBalance() public view returns(uint){ 
        return donutBalances[address(this)];
    }

    function restack(uint amount) public {
        // Require to be the owner
        require(msg.sender == owner, "Only the owner can restack this machine");
        donutBalances[address(this)] += amount;
    }

    // payable function to add ath to the
    function purchase(uint amount) public payable{
        // Is client enough money ?
        require(msg.value >= amount * 2 ether, "You must pay at least 2 ether per donut :<.");

        //Is machine enough donut !?
        require(donutBalances[address(this)] >= amount, "Not enough donuts in stock to fulfill the request.");

        // Loose donut
        donutBalances[address(this)] -= amount;
        donutBalances[msg.sender] += amount;
    }
}