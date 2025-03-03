# CMOS: A MOSS-Like Plagiarism Detection Tool for C Code

## Overview

CMOS (C Moss) is a simplified plagiarism detection tool inspired by MOSS (Measure of Software Similarity). It utilizes lexical analysis and the Winnowing algorithm to identify potential similarities between student-submitted C programs.

## Features

- Tokenizes C source code to remove irrelevant features (e.g., comments, whitespace, variable names).
- Generates numeric token sequences for each submission.
- Creates digital fingerprints using overlapping k-mers and a simple hash function.
- Computes similarity scores between submissions based on shared fingerprints.
- Produces a ranked report of similar submissions for manual review.

## Installation

To compile and run CMOS, you need:

- A Unix-like environment
- `flex` (for lexical analysis)
- `g++` (for compiling the C++ program)

Clone the repository and compile the project:

```sh
make
```

## Usage

Run CMOS by specifying the directory containing student submissions:

```sh
./PlagarismDetector <directory>
```

This will:

1. Tokenize each file in the directory.
2. Generate a `tokens.txt` file.
3. Perform fingerprint analysis.
4. Output a ranked list of similar submissions.

## Project Components

- `cmos.l`: A FLEX lexer for tokenizing C code.
- `cmos.cpp`: A C++ program that implements the Winnowing algorithm for similarity detection.
- `Makefile`: Automates the compilation process.
- `PlagarismDetector`: A provided Bash script that processes multiple files and runs the analysis.

## Implementation Details

- **Tokenization:** Removes comments, whitespace, and normalizes tokens.
- **Winnowing Algorithm:**
  - Converts token sequences into overlapping k-mers.
  - Hashes k-mers and selects minimum hash values from each window.
  - Compares fingerprints across submissions to determine similarity.
- **Similarity Scoring:**
  - Computes shared fingerprints between submissions.
  - Generates a similarity percentage for each pair.

## Output

The program generates a report containing:

- Pairs of submissions ranked by similarity.

## Notes

- The tool is designed for use on `pu3` (the instructor's test machine).
- Ensure compatibility by testing on a school-provided environment.

## License

This project is for educational purposes and follows academic integrity guidelines.
