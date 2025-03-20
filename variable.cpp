#include "variable.h"


Variable::Variable(DILocalVariable* v,std::vector<Instruction*> ass):DIV(v),assigns(ass){}

Variable::Variable(/* args */)
{
}

Variable::~Variable()
{
}

void Variable::add_lines_for_checked(Instruction* assign,int line){
    if(lines_for_checked.find(assign)==lines_for_checked.end()){
        lines_for_checked[assign]=std::vector<int>();
    }
    lines_for_checked[assign].push_back(line);
}


//到了赋值行所在的lexical，收集合法取值的行
void Variable::collectLegalLines(std::vector<DILocation*>& locs,Instruction* assign){
    auto assign_loc = assign->getDebugLoc()->getLine();
    for(auto loc:locs){
        if(loc->getLine() > assign_loc){
            add_lines_for_checked(assign, loc->getLine());
        }
    }
}

void Variable::add_lines(int line){
    linesInLexBlk.insert(line);
}