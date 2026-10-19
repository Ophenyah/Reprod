import math
import random
import sys

TRIALS = 1_000_000
SEED = 20261019

def associativity():
    rng = random.Random(SEED)
    equal = 0

    for _ in range(TRIALS):
        x = rng.uniform(-1e16, 1e16)
        y = rng.uniform(-1e16, 1e16)
        z = rng.uniform(-1e16, 1e16)

        if (x + y) + z == x + (y + z):
            equal += 1

    percentage = 100.0 * equal / TRIALS
    print(f"{percentage:.6f}") #Ophélia : Removed the % to be consistant

def bank():
    balance = math.e

    for year in range(1, 51):
        balance = (balance - 1.0) * year

    balance -= 1.0
    print(balance)

def main():
    if len(sys.argv) != 2:
        print(
            "Usage: python main.py "
            "{associativity|bank}",
            file=sys.stderr,
        )
        sys.exit(1)

    mode = sys.argv[1]

    if mode == "associativity":
        associativity()
    elif mode == "bank":
        bank()
    else:
        print("Unknown mode", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()