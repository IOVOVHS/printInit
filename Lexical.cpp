#include "Lexical.h"
Lexical::Lexical(DILexicalBlock* blk)
{
    this->lex_blk=blk;
}

Lexical::~Lexical()
{
}

void Lexical::addLexical(Lexical* lex){
    this->lexical_blocks.push_back(lex);
    this->isArrived=false;
}

void Lexical::addLoc(DILocation* loc){
    locs.push_back(loc);
}

DIScope* Lexical::getScope(){
    return lex_blk->getScope();
}

n_json Lexical::getJson(int level){
    n_json json_locs = n_json::array();
    std::vector<llvm::DILocation*> used_locs;

    for(auto loc:locs){
        if(find(used_locs.begin(),used_locs.end(),loc)==used_locs.end()){
            used_locs.push_back(loc);
        }else{
            continue;
        }
        n_json loc_json={
            {"line",loc->getLine()},
            {"column",loc->getColumn()}
        };
        json_locs.push_back(loc_json);
    }

    n_json j_lex_blks = n_json::array();
    std::vector<Lexical*> used_blks;
    for(auto lex:lexical_blocks){
        if(find(used_blks.begin(),used_blks.end(),lex)==used_blks.end()){
            used_blks.push_back(lex);
        }else{
            continue;
        }
        n_json j_lex_blk=lex->getJson(level+1);
        j_lex_blks.push_back(j_lex_blk);
    }

    n_json j_all={
        {"locations",json_locs},
        {"level",level},
        {"lexical_blocks",j_lex_blks}
    };

    return j_all;
}

void Lexical::getLinesForDebug(Variable* var){
    auto scope=var->DIV;
    
}

bool Lexical::reachDeclLexBlk(Variable* var){
    if(!lex_blk){
        return false;
    }
    auto localScope = dyn_cast<DILocalScope>(lex_blk);
    if(localScope == dyn_cast<DILocalScope>(var->DIV->getScope())){
        collectDeclLexLines(var);
        return true;
    }else{
        for(auto lex:lexical_blocks){
            lex->reachDeclLexBlk(var);
        }
    }
    return false;
}

bool Lexical::reachAssignLexBlk(Variable* var,Instruction* assign){
    auto scope = assign->getDebugLoc()->getScope();
    if(scope == dyn_cast<DILocalScope>(lex_blk)){
        var->collectLegalLines(locs,assign);
        return true;
    }else{
        for(auto lex:lexical_blocks){
            if(lex->reachAssignLexBlk(var,assign)){
                return true;
            }
        }
    }
    return false;
}

void Lexical::collectDeclLexLines(Variable* var){
    for(auto loc:locs){
        int line = loc->getLine();
        if(var->DIV->getLine() >  line){
            var->add_lines(loc->getLine());
        }
    }

    for(auto lex:lexical_blocks){
        lex->collectDeclLexLines(var);
    }
}

/*
void to_json(json& j,DILocation* loc){
    if(loc){
        j = json{
            {"line", loc->getLine()},
            {"column", loc->getColumn()}
        };
    }else{
        j =nullptr;
    }
}

void to_json(json& j, const Lexical& obj){
    j = json{
        {"locs", obj.locs},
        {"lex_blks",obj.lexical_blocks,}
    };
}
*/