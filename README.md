# CryptoTipJar

CryptoTipJar is a simple Ethereum smart contract that allows users to send ETH tips to the contract owner.

## Features

- Users can send ETH tips
- Each user's total tips are recorded
- Anyone can view the contract balance
- Only the contract owner can withdraw funds
- Emits events when tips are received and funds are withdrawn

## Smart Contract

The main contract is located in:

`src/CryptoTipJar.sol`

## Testing

The project contains tests covering:

- Owner initialization
- Sending tips
- Multiple users sending tips
- Rejecting zero-value tips
- Preventing non-owners from withdrawing
- Owner withdrawals
- Preventing withdrawals when the balance is zero

Run the tests with:

```bash
forge test