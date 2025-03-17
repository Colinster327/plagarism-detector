//Authors: Colin Murphy & Brock Klamfoth
//Date: 3/17/25

#include <fstream>
#include <functional>
#include <iostream>
#include <limits>
#include <string>
#include <vector>

using namespace std;

// Structure to store the program name, token and fingerprints
struct ProgramToken {
  string name;
  string token;
  vector<size_t> fingerprints;
};

// Structure to store the similarity between two programs
struct Similarity {
  string name1;
  string name2;
  double similarity;
};

int main() {
  fstream file("./tokens.txt", ios::in);
  vector<ProgramToken> programs;
  string name, token;

  // read the program name and token from the file
  while (file >> name >> token) {
    ProgramToken pt = {name, token};
    programs.push_back(pt);
  }

  file.close();

  // for each program, calculate the fingerprints
  for (auto &pt : programs) {
    size_t k = 4;
    size_t w = 4;
    hash<string> hasher;

    // calculate the hash value of each 4mer
    vector<size_t> kmer_hashes;
    if (pt.token.length() >= k) {
      for (size_t i = 0; i <= pt.token.length() - k; ++i) {
        string kmer = pt.token.substr(i, k);
        size_t hash_value = hasher(kmer);
        kmer_hashes.push_back(hash_value);
      }
    }

    // calculate the fingerprint of each window
    for (size_t i = 0; i <= kmer_hashes.size() - w; ++i) {
      size_t min_hash = numeric_limits<size_t>::max();
      for (size_t j = 0; j < w; ++j) {
        if (kmer_hashes[i + j] < min_hash) {
          min_hash = kmer_hashes[i + j];
        }
      }
      pt.fingerprints.push_back(min_hash);
    }
  }

  vector<Similarity> similarities;

  // calculate the similarity between each pair of programs
  for (size_t i = 0; i < programs.size(); ++i) {
    for (size_t j = i + 1; j < programs.size(); ++j) {
      size_t common = 0;
      for (size_t k = 0; k < programs[i].fingerprints.size(); ++k) {
        for (size_t l = 0; l < programs[j].fingerprints.size(); ++l) {
          if (programs[i].fingerprints[k] == programs[j].fingerprints[l]) {
            common++;
          }
        }
      }

      double similarity = (double)common / (programs[i].fingerprints.size() +
                                            programs[j].fingerprints.size());
      similarities.push_back({programs[i].name, programs[j].name, similarity});
    }
  }

  // sort the similarities in descending order
  sort(similarities.begin(), similarities.end(),
       [](const Similarity &a, const Similarity &b) {
         return a.similarity > b.similarity;
       });

  // print the similarities
  for (const auto &similarity : similarities) {
    cout << similarity.name1 << " " << similarity.name2 << " "
         << similarity.similarity << endl;
  }
}
