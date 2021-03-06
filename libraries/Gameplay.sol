/**
 *Submitted for verification at Etherscan.io on 2021-09-05
 */

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";

import "../libraries/Base64.sol";


/// [MIT License]
/// @title Gameplay
/// @notice Provides a function for encoding some bytes in base64
/// @author Brecht Devos <brecht@loopring.org>
library Gameplay {
    struct Properties {
	uint id;
	string name;
	string imageURI;
    }

    struct Attributes {
	uint hp;
	uint armour;
	uint damage;
    }

    struct Character {
	Properties props;
	Attributes attr;
    }

    struct GameState {
	Character player;
	Character enemy;
    }

    function attack(GameState memory _state) internal pure returns (GameState memory) {
	Character memory _player = _state.player;
	Character memory _enemy = _state.enemy;

	// Make sure the player has more than 0 HP.
	require (
	    _player.attr.hp > 0,
	    "Error: character must have HP to attack boss."
	);

	// Make sure the boss has more than 0 HP.
	require (
	    _enemy.attr.hp > 0,
	    "Error: boss must have HP to attack boss."
	);

	// Allow player to attack boss.
	if (_enemy.attr.hp < _player.attr.damage) {
	    _enemy.attr.hp = 0;
	} else {
	    _enemy.attr.hp = _enemy.attr.hp - _player.attr.damage;
	}

	GameState memory newState = GameState({
	    player: _player,
	    enemy: _enemy
	});

	return newState;
    }
}
