#include "../../template/start.cpp"

string quote(const string& path) { return '"' + path + '"'; }

int runCommand(const string& command) {
    if constexpr(filesystem::path::preferred_separator == '\\')
        return system(('"' + command + '"').c_str());
    return system(command.c_str());
}

bool sameTokens(const string& firstFile, const string& secondFile) {
    ifstream first(firstFile), second(secondFile);
    string a, b;
    while(true) {
        bool hasA = bool(first >> a), hasB = bool(second >> b);
        if(hasA != hasB) return false;
        if(!hasA) return true;
        if(a != b) return false;
    }
}

int main(int argc, char** argv) {
    if(argc < 4 || argc > 5) {
        cerr << "usage: stress generator brute solve [tests]\n";
        return 2;
    }
    int tests = argc == 5 ? stoi(argv[4]) : 10000;
    const string input = "stress.in", expected = "stress.ans", actual = "stress.out";
    for(int seed = 1; seed <= tests; seed++) {
        string generate = quote(argv[1]) + " " + to_string(seed) + " > " + quote(input);
        string runBrute = quote(argv[2]) + " < " + quote(input) + " > " + quote(expected);
        string runSolve = quote(argv[3]) + " < " + quote(input) + " > " + quote(actual);
        for(auto&& [name, command] : {
                pair{"generator", generate}, pair{"brute", runBrute}, pair{"solve", runSolve}}) {
            int status = runCommand(command);
            if(status != 0) {
                cerr << name << " failed: seed=" << seed << ", status=" << status << '\n';
                return 2;
            }
        }
        if(!sameTokens(expected, actual)) {
            cerr << "mismatch: seed=" << seed << '\n';
            return 1;
        }
    }
    cerr << "accepted " << tests << " tests\n";
    return 0;
}
