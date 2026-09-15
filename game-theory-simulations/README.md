# Game Theory Simulations

Two small simulations written during my Applied Computational Mathematics
coursework at Florida State University, exploring strategic bidding behaviour.

These were originally committed alongside an unrelated stock-prediction project;
they are grouped here on their own because the subject matter is distinct.

## Contents

| Script | What it does |
|---|---|
| `ascendingBid.py` | Models an ascending-bid (English) auction and checks whether a given strategy profile is a **Nash equilibrium**, by testing each player for a profitable unilateral deviation across the payoff matrix. |
| `carAuction.py` | Simulates two bidders competing for a car under **aggressive vs. conservative** strategies, where each player's behaviour is driven by a tunable risk factor, and plots the resulting bidding history. |

## Concepts

Nash equilibrium · best-response / unilateral deviation · ascending-bid auctions ·
risk-adjusted bidding strategy

## Stack

Python · numpy · matplotlib

## Running

```bash
python ascendingBid.py
python carAuction.py
```
