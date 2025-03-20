#ifndef _LexicalBlock
#define _LexicalBlock
#include<vector>
#include "llvm/IR/DebugInfo.h"
#include "llvm/IR/Instruction.h"
#include "json.hpp"
#include "variable.h"

using n_json = nlohmann::json;
using DILocation = llvm::DILocation;
using DILexicalBlock =llvm::DILexicalBlock;
using DIScope = llvm::DIScope;

class Lexical
{
private:

public:
    bool isArrived;
    std::vector<DILocation*> locs;
    std::vector<Lexical*> lexical_blocks;
    DILexicalBlock* lex_blk;
    void addLoc(DILocation*);
    DIScope* getScope();
    void addLexical(Lexical*);
    n_json getJson(int level);
    
    //由DILoction找到对应的词法作用域，再从词法作用往下找
    void getLinesForDebug(Variable* var);

    bool reachDeclLexBlk(Variable* var);

    bool reachAssignLexBlk(Variable* var,Instruction*);

    void collectDeclLexLines(Variable* v);
    Lexical(DILexicalBlock*);
    ~Lexical();
};
/*
void to_json(json& j,DILocation* loc);
void to_json(json& j, const Lexical& obj);
*/
#endif