#ifndef _VARIABLE
#define _VARIABLE

#include "llvm/IR/PassManager.h"
#include "llvm/IR/DebugInfo.h"
#include <unordered_set>
#include <vector>

using namespace llvm;

class Variable
{
private:

public:
    DILocalVariable* DIV;
    std::vector<Instruction*> assigns;
    std::unordered_map<Instruction*, std::vector<int>> lines_for_checked;
    std::unordered_set<int> linesInLexBlk;
    Variable(/* args */);
    Variable(DILocalVariable* v,std::vector<Instruction*>);
    ~Variable();

    void add_lines(int line);

    void add_lines_for_checked(Instruction* assign,int line);

    void collectLegalLines(std::vector<DILocation*>& locs,Instruction* assign);
};



#endif