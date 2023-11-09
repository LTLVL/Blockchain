// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

// Uncomment the line to use openzeppelin/ERC721
// You can use this dependency directly because it has been installed by TA already
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
//import "./IERC4907.sol";
// Uncomment this line to use console.log
import "hardhat/console.sol";

contract BorrowYourCar {
// use a event if you want
    // to represent time you can choose block.timestamp
    event CarBorrowed(uint32 carTokenId, address borrower, uint256 startTime, uint256 duration);

    // maybe you need a struct to store car information
    struct Car {
        address owner;
        address borrower;
        uint256 borrowUntil;
    }

    mapping(uint256 => Car) public cars; // A map from car index to its information

    uint256[] keys;

    constructor() {
        // maybe you need a constructor
        for (uint i = 0; i < 100; i++){
            uint256 key = i + 10000;
            Car memory car;
            car.owner = address(this);
            car.borrower = address(0);
            car.borrowUntil = 0;
            cars[key] = car;
            keys.push(key);
        }
    }

    function helloworld() pure external returns(string memory) {
        return "hello world";
    }

    //根据car的id查询相关信息
    function QueryCarInfo(uint256 car) view public returns(address owner, address borrower, uint256 borrowUntil) {
        return (cars[car].owner, cars[car].borrower, cars[car].borrowUntil);
    }

    // 查看自己拥有的汽车列表
    function QueryMyCars() view public returns(uint256[] memory) {
        uint256[] memory car_infos = new uint256[](keys.length);
        uint256 count = 0;
        address sender = msg.sender;
        for (uint i = 0; i < keys.length; i++) {
            if(sender == cars[keys[i]].owner){
                car_infos[i] = keys[i];
                count++;
            }
        }
        uint256[] memory car_infos_ = new uint256[](count);
        count = 0;
        for (uint i = 0; i < keys.length; i++){
            if(car_infos[i] != 0){
                car_infos_[count] = car_infos[i];
                count++;
            }
        }
        return (car_infos_);
    }

    //查询所有汽车
    function QueryAllCars() view public returns(uint256[] memory) {
        return keys;
    }

    // 查看自己租界的汽车列表
    function QueryMyBorrowCars() view public returns(uint256[] memory) {
        uint256[] memory car_infos = new uint256[](keys.length);
        uint256 count = 0;
        address sender = msg.sender;
        for (uint i = 0; i < keys.length; i++) {
            if(sender == cars[keys[i]].borrower && cars[keys[i]].borrowUntil > block.timestamp){
                car_infos[i] = keys[i];
                count++;
            }
        }
        uint256[] memory car_infos_ = new uint256[](count);
        count = 0;
        for (uint i = 0; i < keys.length; i++){
            if(car_infos[i] != 0){
                car_infos_[count] = car_infos[i];
                count++;
            }
        }
        return (car_infos_);
    }

    // 查看还未被借出的汽车列表
    function QueryFreeCars() view external returns(uint256[] memory) {
        uint256[] memory car_infos = new uint256[](keys.length);
        uint256 count = 0;
        for (uint i = 0; i < keys.length; i++) {
            uint256 key = keys[i];
            Car memory value = cars[key];
            if(value.borrowUntil < block.timestamp){
                car_infos[i] = key;
                count++;
            }
        }
        uint256[] memory car_infos_ = new uint256[](count);
        count = 0;
        for (uint i = 0; i < keys.length; i++){
            if(car_infos[i] != 0){
                car_infos_[count] = car_infos[i];
                count++;
            }
        }
        return (car_infos_);
    }

    // 用户测试领取汽车NFT
    function PickUpNFT() payable public returns(uint256) {
        require(msg.value >= 1 ether, "At least 1 ether");
        uint256 car;
        for (uint i = 0; i < keys.length; i++) {
            uint256 key = keys[i];
            if(cars[key].owner == address(this)){
                cars[key].owner = msg.sender;
                car = keys[i];
                address payable payer = payable(msg.sender);
                payer.transfer(msg.value - 1 ether);
                break;
            }
        }
        return car;
    }

    // 用户选择并借用某辆还没有被租借的汽车一定时间
    function BorrowCar(uint256 car, uint256 time) public{
        require(cars[car].owner == address(0) || cars[car].borrowUntil < block.timestamp, "Car has already been borrowed");
        cars[car].borrower = msg.sender;
        cars[car].borrowUntil = block.timestamp + time;
    }

    function BalanceOf() view public returns(uint256) {
        return address(this).balance;
    }

    function uintToString(uint256 value) private  pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }


    function strConcat(string memory _a, string memory _b) private  pure returns (string memory){
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        string memory ret = new string(_ba.length + _bb.length);
        bytes memory bret = bytes(ret);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) bret[k++] = _ba[i];
        for (uint i = 0; i < _bb.length; i++) bret[k++] = _bb[i];
        return string(ret);
    }

    function toLowerCase(address _address) internal pure returns (address) {
        return address(bytes20(keccak256(abi.encodePacked(_address))));
    }

    function toUpperCase(address _address) internal pure returns (address) {
        return address(bytes20(keccak256(abi.encodePacked(_address))));
    }
}