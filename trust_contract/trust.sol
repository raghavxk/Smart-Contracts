pragma solidity ^0.8.12;

contract Trust {
    mapping(address => uint256) amounts;
    mapping(address => uint256) maturities;
    address[] public kids;
    mapping(address => bool) paid;
    address public parent;

    constructor() {
        parent = msg.sender;
    }

    // modifiers
    modifier isParent() {
        require(msg.sender == parent, "Can only be accessed by parent.");
        _;
    }

    modifier isNotPaidAlready() {
        require(paid[msg.sender] == false, "You have already been paid");
        _;
    }

    modifier isKid() {
        bool isPresent = false;
        for (uint256 i; i < kids.length; ++i) {
            if (kids[i] == msg.sender) {
                isPresent = true;
                break;
            }
        }
        require(isPresent == true, "Funds can only be accessed by kids");
        _;
    }

    // util functions
    function kidExists(address _kid) internal view returns (bool) {
        for (uint256 i; i < kids.length; ++i) {
            if (kids[i] == _kid) {
                return true;
            }
        }
        return false;
    }


    function addKid(address _kid, uint256 _timeToMaturity)
        external
        payable
        isParent
    {
        require(kidExists(_kid) == false, "Kid already exists");
        amounts[_kid] = msg.value;
        maturities[_kid] = block.timestamp + _timeToMaturity;
        kids.push(_kid);
    }

    function withdraw() external payable isKid isNotPaidAlready {
        require(
            block.timestamp > maturities[msg.sender],
            "Too early ! can not withdraw funds"
        );
        paid[msg.sender] == true;
        payable(msg.sender).transfer(amounts[msg.sender]);
    }
}
