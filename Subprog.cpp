#include "Subprog.h"

Subprog::Subprog(DISubprogram* Subprog)
{
    this->func=Subprog;
}

Subprog::~Subprog()
{
    
}

void Subprog::addLexical(Lexical* lex_blk){
    lex_blks.push_back(lex_blk);
}

void Subprog::addLoc(DILocation* loc){
    locs.push_back(loc);
}

bool Subprog::isIncludeLex(DILexicalBlock* lexical_block){
    for(auto lex_blk:lex_blks){
        if(lex_blk->lex_blk==lexical_block){
            return true;
        }
    }
    return false;
}
void printTab(int k){
    while(k){
        llvm::errs()<<" ";
        k--;
    }
}

n_json Subprog::getJson(){
    if(func==nullptr){
        //llvm::errs()<<" func is null "<<"\n";
        return nullptr;
    }
    n_json json_locs = n_json::array();
    std::vector<llvm::DILocation*> used_locs;


    for(auto loc:locs){
        if(find(used_locs.begin(),used_locs.end(),loc)==used_locs.end()){
            used_locs.push_back(loc);
        }else{
            continue;
        }
        n_json loc_json={
            {"line", loc->getLine()},
            {"column", loc->getColumn()}
        };
        json_locs.push_back(loc_json);
    }

    n_json l_test=n_json::object();
    
    n_json j_lex_blks=n_json::array();
    int level=0;
    std::vector<Lexical*> used_blks;

    for(auto lex_blk:lex_blks){
        if(find(used_blks.begin(),used_blks.end(),lex_blk)==used_blks.end()){
            used_blks.push_back(lex_blk);
        }else{
            continue;
        }
        n_json lex_json=lex_blk->getJson(level+1);
        j_lex_blks.push_back(lex_json);
    }

    n_json j_all={
        {"func",func->getName()},
        {"loctions", json_locs},
        {"level", level},
        {"lexical_blocks", j_lex_blks}
    };
    
    //llvm::errs()<<j_subprog.dump(4)<<"\n";
    return j_all;
}


void Subprog::getLinesForDebug(Variable* var){
    if(!func){
        return;
    }
    auto scope=var->DIV->getScope();
    auto current_scope = dyn_cast<DILocalScope>(func);
    auto var_subprog = var->DIV->getScope()->getSubprogram();
    if(var_subprog != func){
        return;
    }else{
        reachDeclLexBlk(var);
    }
}

void Subprog::collecDeclLexLines(Variable* var){
    for(auto loc:locs){
        int line = loc->getLine();
        if(line > var->DIV->getLine()){
            var->add_lines(line);
        }
    }
    for(auto lex:lex_blks){
        lex->collectDeclLexLines(var);
    }
}

bool Subprog::reachDeclLexBlk(Variable* var){
    if(!func){
        return false;
    }
    auto localScope = dyn_cast<DILocalScope>(func);
    if(localScope == dyn_cast<DILocalScope>(var->DIV->getScope())){
        //到达声明行所在词法块，寻找赋值行所在词法块
        //这里有两种情况：1.赋值行和声明行在同个词法块
        // 2.赋值行在声明行所在词法块的下一级词法块中
        collecDeclLexLines(var);
        return true;
        //reachAssignLexBlk(var);
    }else{
        for(auto lex_blk:lex_blks){
            if(lex_blk->reachDeclLexBlk(var)){
                break;
            }
        }
    }
    return false;
}


void Subprog::reachAssignLexBlk(Variable* var){
    for(auto assgin:var->assigns){
        auto loc=assgin->getDebugLoc();
        if(loc){
            if(loc->getScope() == dyn_cast<DILocalScope>(func)){
                var->collectLegalLines(locs,assgin);
            }
        }else{
            for(auto lex_blk:lex_blks){
                //找到赋值行所在的词法块
                if(lex_blk->reachAssignLexBlk(var,assgin)){
                    break;
                }
            }
        }
    }
}

/*
void to_json(json& j,const DILocation* loc){
    if(loc){
        j = json{
            {"line", (int)loc->getLine()},
            {"column", (int)loc->getColumn()}
        };
    }else{
        j =nullptr;
    }
}

void to_json(json& j, const std::vector<DILocation*>& locs) {
    j = json::array();
    for (auto loc : locs) {
        json loc_json;
        to_json(loc_json, loc);  // 调用我们为 DILocation* 定义的 to_json 函数
        j.push_back(loc_json);
    }
}

void to_json(json& j, const Subprog& obj){
    j = json{
        {"locs", obj.locs},
        {"blks", obj.lex_blks}
    };

}
*/