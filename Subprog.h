#ifndef _SubProg
#define _SubProg

#include<vector>
#include "llvm/IR/DebugInfo.h"
#include "Lexical.h"
#include <string>
#include <fstream>

/*
using DILocation = llvm::DILocation;
using DILexicalBlock =llvm::DILexicalBlock;
using DIScope = llvm::DIScope;
using DISubprogram = llvm::DISubprogram;
*/

using n_json = nlohmann::json;

using DISubprogram = llvm::DISubprogram;
class Subprog
{
private:

public:
    std::vector<Lexical*> lex_blks;
    std::vector<DILocation*> locs;

    n_json getJson();
    
    DISubprogram* func;
    void addLexical(Lexical*);
    void addLoc(DILocation*);
    bool isIncludeLex(DILexicalBlock*);

    //判断变量是否在对应的函数
    void getLinesForDebug(Variable* var);

    //到达声明行所在的词法作用域
    bool reachDeclLexBlk(Variable* var);

    //到达赋值行所在的词法作用域
    void reachAssignLexBlk(Variable* var);

    //收集变量的声明行所在的词法作用域的行
    void collecDeclLexLines(Variable* var);

    Subprog(DISubprogram*);
    ~Subprog();
};

void printTab(int k);

/*
void to_json(json& j, const DILocation* loc);
void to_json(json& j, const std::vector<DILocation*>& locs);
void to_json(json& j, const Subprog& obj);
*/
#endif