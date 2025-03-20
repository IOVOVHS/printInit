#ifndef _PassInit
#define _PassInit


#include "llvm/Pass.h"
#include "llvm/Support/Debug.h"
//#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include <unordered_map>
#include <algorithm>
#include <iostream>
#include <fstream>

#include "Subprog.h"

using namespace llvm;
#define DEBUG_TYPE "printinit"



using n_json = nlohmann::json;
namespace
{

    typedef struct _Var
    {
        StringRef name;
        int line;
        StringRef type;
        _Var(){};
        ~_Var(){};
    } Var;

    std::vector<Instruction*> lineInsts;

    void printVec(const std::vector<Instruction*> &vec){
        for(Instruction* v:vec){
            errs()<<"func name : "<<v->getFunction()->getName();
            errs()<<"inst address : "<<v<<" ; ";
            errs()<<"instruction : "<<*v<<"\n"; 
        }
    }

    struct PrintInit : PassInfoMixin<PrintInit>
    {        

        PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM)
        {
            std::vector<Instruction*> InstVec;
            std::vector<Instruction*> dbgInstVec; 

            std::vector<Value*> ValueVec;
            std::vector<Value*> dbgValue;
            std::unordered_map<Value*,std::vector<Instruction*>> v_to_inst;
            //std::unordered_map<Value*,Instruction*> v_to_inst;
            std::unordered_map<Value*,DbgInfoIntrinsic*> v_to_dbg;
            std::vector<Value*> resValue;
            std::vector<std::pair<std::string,int>> res;
            

            std::vector<Value*> bitCastValue;
            std::vector<Value*> dbgBitcast;

            std::vector<Var*> vars;
            std::vector<std::unique_ptr<Var>> vec;
            std::unordered_map<Instruction*,DbgInfoIntrinsic*> dbgMap;
            std::unordered_map<DILexicalBlock*,std::vector<DILexicalBlock*>*> scopeMap;
            std::fstream f; 
            std::string filename=M.getSourceFileName();
            auto pos=filename.find_last_not_of(".");
            auto start=filename.rfind("/");
            auto end=filename.rfind(".");
            auto filepath="/Users/lain/codeFiles/llvm-pass/printInit/"+filename.substr(start+1,end-start)+"json";
            //f.open("/home/hzw/experiment/temp/random_1.txt",std::ios::out|std::ios::app);
            //errs()<<filepath<<"\n";
            f.open(filepath,std::ios::out|std::ios::app); 
            // std::vector<Instruction> InstVec;
            //errs() << "I saw a function called " << F.getName() << "!\n";
            //the first time of traverse
            std::vector<Value*> arg_vals;
            for(Function &F:M){
                for(auto begin=F.arg_begin(),end=F.arg_end();begin!=end;begin++){
                    arg_vals.push_back(dyn_cast<Value>(begin));
                }

                for (BasicBlock &BB : F)
                {
                    for (Instruction &I : BB)
                    {
                        if(vecFind(InstVec,&I)){
                            continue;
                        }
                        
                        //errs() << "Instruction:" << I << " " << I.isUsedByMetadata() <<"\n";
                        //errs()<<I.getNumOperands()<<"\n";
                        
                        // get the operand of storeInst,If the storeInst's operand include constant,then the another join the res vector;

                        if(auto st_Inst=dyn_cast<StoreInst>(&I)){
                            //errs()<<"store instruction : "<<*var<<"\n";
                            if(auto cons= dyn_cast<Constant>(st_Inst->getOperand(0))){
                                //if(cons->isNullValue()){
                                //    continue;
                                //}
                                if(isa<ConstantPointerNull>(cons)){
                                    continue;
                                }
                                if(isa<Instruction>(st_Inst->getOperand(1))){
                                    InstVec.push_back(cast<Instruction>(st_Inst->getOperand(1)));
                                    ValueVec.push_back(cast<Value>(st_Inst->getOperand(1)));
                                    v_to_inst[st_Inst->getOperand(1)].push_back(st_Inst);
                                }
                            }
                            if(auto cons=dyn_cast<Argument>(st_Inst->getOperand(0))){
                                InstVec.push_back(cast<Instruction>(st_Inst->getOperand(1)));
                                ValueVec.push_back(cast<Value>(st_Inst->getOperand(1)));
                                v_to_inst[st_Inst->getOperand(1)].push_back(st_Inst);
                            }
                            //LLVM_DEBUG(dbgs() <<" store inst: "<< I << "\n");
                            /*
                            for(Value *V:var->operand_values()){
                                sv.push_back(V);
                                if(auto Inst=dyn_cast<Instruction>(V)){
                                    errs()<<" store operand instruction : " <<*Inst<<"\n"; 
                                }
                                if(auto constant=dyn_cast<Constant>(V)){
                                    errs()<<" store operand constant : " <<*constant<<"\n"; 
                                }
                            }*/
                        }
                        if(auto var=dyn_cast<BitCastInst>(&I)){
                            InstVec.push_back(var);
                            Value* value=I.getOperand(0);
                            bitCastValue.push_back(value);
                            ValueVec.push_back(value);
                            v_to_inst[value].push_back(var);
                            //InstVec.push_back(cast<Instruction>(var->getOperand(0)));
                        }
                    }
                }
            }

            
            //printVec(InstVec);
            bool change=false;
            do{
                change=false;
                // the other traverse
                for(Function &F:M){
                    for (BasicBlock &BB : F)
                    {
                        for (Instruction &I : BB)
                        {
                            //exclude the inst in InstVec

                            
                            if(vecFind(InstVec,&I)){
                                continue;
                            }

                            // check the inst,if the operand includes unknown,then break,else put it in.
                            //the inst must give a new "value" such as mul but not br.StoreInst is another case.
                            if (isCompute(&I))
                            {
                                
                                bool init=true;
                                for (Value *V : I.operand_values())
                                {
                                     
                                    // if it is const type
                                    if (dyn_cast<Constant>(V))
                                    {
                                        continue;
                                    }
                                    if(find(ValueVec.begin(),ValueVec.end(),V)==ValueVec.end() && find(arg_vals.begin(),arg_vals.end(),V)==arg_vals.end()){
                                        init=false;
                                        break;
                                    }
                                }
                                if(init){
                                    //LLVM_DEBUG(dbgs() << "inited_Inst" << I << "\n");
                                    errs() << "func_name : " << I.getFunction()->getName() << "inited_Inst" << I << "\n";
                                    Value* resValue=dyn_cast<Value>(&I);
                                    InstVec.push_back(&I);
                                    ValueVec.push_back(resValue);
                                    v_to_inst[resValue].push_back(&I);
                                    change=true;
                                }
                            }
                            else if(auto storeInst=dyn_cast<StoreInst>(&I)){
                                auto leftValue=storeInst->getOperand(0);
                                if(leftValue){
                                    if(find(ValueVec.begin(),ValueVec.end(),leftValue)!=ValueVec.end()){
                                        ValueVec.push_back(storeInst->getOperand(1));
                                        InstVec.push_back(&I);
                                        v_to_inst[storeInst->getOperand(1)].push_back(&I);
                                    }
                                }
                            }
                        }
                    }
                }
            }while(change);

            //找到被debug inrinsic记录的变量。
            std::unordered_map<Value*,StringRef> v_to_f_name;
            for(Function &F:M){
                for(BasicBlock &BB: F){
                    for(Instruction &I : BB){
                        if(auto dbgInst=dyn_cast<DbgInfoIntrinsic>(&I)){
                            //errs()<<*dbgInst<<"\n";
                            for(Value *V:dbgInst->operand_values()){
                                if(auto m=dyn_cast<MetadataAsValue>(V)){
                                    if(auto t=dyn_cast<ValueAsMetadata>(m->getMetadata())){
                                        Value *v_inst=t->getValue();
                                        dbgValue.push_back(v_inst);
                                        v_to_f_name[v_inst]=F.getName();
                                        v_to_dbg[v_inst]=dbgInst;
                                    }
                                }
                            }
                        }
                    }
                }
            }

            //找到valueVec哪些变量是被调试原语记录的，放入resValue中，这样就可以找到对应的初始化指令，找到对应的源代码行。
            for(Value* v:dbgValue){
                //errs()<<*v<<"\n";
                if(find(ValueVec.begin(),ValueVec.end(),v)!=ValueVec.end()){
                    resValue.push_back(v);
                }
            }

            //找到这些变量对应的debugInfo原语类，随后看是否是DbgDeclareInst类，然后就可以得到对应的变量名和行号。
            errs()<<"this line"<<"\n";
            //以下内容是将遍历变量对应的Value，declare以及多个赋值指令
            //添加内容：找到assign对应的scope（lexical、subprog），收集scope内该行后面的源代码行
            //再找到声明行所在的scope，

            //这里收集变量的信息
            std::vector<Variable*> variables;

            for(Value* v:resValue){
                //find the init Inst; 
                auto dbgI=v_to_dbg[v];
                errs()<<"---"<<"\n";
                if(auto dbgD=dyn_cast<DbgDeclareInst>(dbgI)){
                    DILocalVariable* DIV=dbgD->getVariable();
                    if(DIV){
                        auto decl_row=DIV->getLine();
                        //errs()<< "decl row : " << decl_row<< "\n";
                        StringRef var_name=DIV->getName();
                        llvm::errs()<<var_name<<"\n";
                        auto InitInsts=v_to_inst[v];
                        variables.push_back(new Variable(DIV,InitInsts));
                    }
                    //f<<j_var<<"\n";
                }
            }


            
//    -------------     打印Json ----------------

            errs()<<"Print Json"<<"\n";


            //遍历指令，得到指令上一级范围
            std::vector<Subprog*> _subprogs;
            std::vector<Lexical*> _lexicals;
            for(Function &F:M){
                //得到这个函数的subprog
                Subprog* subprog=new Subprog(F.getSubprogram());
                _subprogs.push_back(subprog);
                for(BasicBlock &B:F){
                    for(Instruction &I:B){
                        if(DILocation *Loc=I.getDebugLoc()){
                            auto Scope=Loc->getScope();
                            //如果已经有了词法块，则使用对应的词法块加入行，否则创建后再加入
                            if(DILexicalBlock *lex_blk=dyn_cast<DILexicalBlock>(Scope)){
                                auto lexical=lexFind(_lexicals,lex_blk);
                                if(lexical){
                                    lexical->addLoc(Loc);
                                }else{
                                    Lexical* lex=new Lexical(lex_blk);
                                    lex->addLoc(Loc);
                                    _lexicals.push_back(lex);
                                }
                            }else if(DISubprogram *s_prog=dyn_cast<DISubprogram>(Scope)){
                                //如果是函数，则直接添加该行
                                subprog->addLoc(Loc);
                            }
                        }
                    }
                }
            }
            
            //不实用extended_lex_blks重新写,为了检查这个词法块是否能达到函数，加入一个字段isArrived。
            for(auto lex:_lexicals){
                auto scope=lex->getScope();
                Lexical* lex_blk_down=lex;
                while(scope){
                    if(auto lex_blk_up_scope=dyn_cast<DILexicalBlock>(scope)){
                        auto lex_blk_up=lexFind(_lexicals,lex_blk_up_scope);
                        //现有的词法块有这个词法块，直接加入
                        if(lex_blk_up){
                            lex_blk_up->addLexical(lex_blk_down);
                            lex_blk_down->isArrived=true;
                            //上一级已经能到函数
                            if(lex_blk_up->isArrived){
                                break;
                            }
                        }else{
                            //第一次找到，则创建，加入，并向上找
                            lex_blk_up=new Lexical(lex_blk_up_scope);
                            lex_blk_up->addLexical(lex_blk_down);
                            lex_blk_down->isArrived=true;
                        }
                        lex_blk_down=lex_blk_up;
                    }else if(auto lex_blk_up_scope=dyn_cast<DISubprogram>(scope)){
                        //找到函数对应的subprog，检查是否加入了这个词法块，如果加入了，则直接将代码
                        Subprog* subprog=nullptr;
                        for(auto subp:_subprogs){
                            if(subp->func==lex_blk_up_scope){
                                subprog=subp;
                                break;
                            }
                        }
                        //只要是回溯到函数的那就一定是还没加入函数的，直接加入就可以
                        subprog->addLexical(lex_blk_down);
                        lex_blk_down->isArrived=true;
                        break;
                    }else{
                        errs()<<"unkonwn lexical block,maybe an error." << "\n";
                    }
                    
                    scope=scope->getScope();
                }
            }

            for(auto subp:_subprogs){
                for(auto variable:variables){
                    subp->reachDeclLexBlk(variable);
                }
            }

            n_json var_array = n_json::array();

            for(auto variable:variables){
                    n_json j_assigns=n_json::array();
                    for(auto InitInst:variable->assigns){
                        DebugLoc DL=InitInst->getDebugLoc();
                        
                        DILocation* DI=DL.get();
                        int line=0;
                        if(DI){
                            line=DI->getLine();
                        }
                        j_assigns.push_back(line);
                    }
                    n_json j_lines = n_json::array();
                    for(int line:variable->linesInLexBlk){
                        j_lines.push_back(line);
                    }
                    n_json j_var = {
                        {"name", variable->DIV->getName()},
                        {"func", variable->DIV->getScope()->getSubprogram()->getName()},
                        {"lines_for_checked:",j_lines},
                        {"decl", variable->DIV->getLine()},
                        {"assigns",j_assigns}
                    };
                    var_array.push_back(j_var);
            }
            errs()<<var_array.size()<<"\n";
            n_json subprog_array=n_json::array();
            //至此遍历完所有的词法块指令，每个loc都应该能溯源到函数，开始打印json格式。
            for(auto subp:_subprogs){
                auto subp_json=subp->getJson();
                if(subp_json!=nullptr){
                    subprog_array.push_back(subp_json);
                }
            }
            errs()<<subprog_array.size()<<"\n";
            n_json j_all=n_json{
                {"var_info",var_array},
                {"lexical_info",subprog_array}
            };
            f<<j_all.dump(2)<<"\n";
/*
这里使用了extended_lex_blks表示中间词法块，这样写反而看不懂了。重新写了。

            std::vector<Lexical*> extended_lex_blks;
            //遍历范围，不断向上找，保证每个指令都可以溯源到函数
            for(auto lex:_lexicals){
                auto scope=lex->getScope();
                Lexical* lex_blk_down=lex;
                while(scope){
                    if(auto lex_blk_scope=dyn_cast<DILexicalBlock>(scope)){
                        //如果上一级词法块不在已经找到的第一级词法块中
                        if(!lexFind(_lexicals,lex_blk_scope)){
                            //在中间的词法块中找
                            auto lexical_ext=lexFind(extended_lex_blks,lex_blk_scope);
                            //第一次找到这个词法块
                            if(!lexical_ext){
                                Lexical* lex_up=new Lexical(lex_blk_scope);
                                lex_up->addLexical(lex_blk_down);
                                extended_lex_blks.push_back(lex_up);
                            }else{
                                //否则加入已有词法块
                                lexical_ext->addLexical(lex_blk_down);
                                lex_blk_down=lexical_ext;
                            }
                        }
                        scope=lex_blk_scope->getScope();
                    //溯源到函数，检查函数是否包括这个词法块，没有的话则加入词法块。首先找到对应的Subprogram对象，
                    }else if(auto lex_blk_scope=dyn_cast<DISubprogram>(scope)){
                        Subprog* subprog=nullptr;
                        for(auto subp:_subprogs){
                            if(subp->func==lex_blk_scope){
                                subprog=subp;
                                break;
                            }
                        }
                        //找到了词法块对应的函数后，检查函数有没有加入这个词法块，没有则增加
                        if(!subprog->isIncludeLex(lex_blk_down->lex_blk)){
                            subprog->addLexical(lex_blk_down);
                        }
                        break;
                    }else{
                        errs()<<"unkonwn lexical block,maybe an error." << "\n";
                    }
                }
            }
        
            //至此遍历完所有的词法块指令，每个loc都应该能溯源到函数，开始打印json格式。
            for(auto subp:_subprogs){
                subp->printJson(f);
            }
*/



/*
//这里的是未运行的使用哈希表的方式写的。抛弃。
            //遍历指令，得到对应的DILocation，得到行和列信息，看inst所属的词法类对象
            //遍历指令，找到指令所属的词法块，再从这个词法块找到所属的词法块，最后到函数
            std::unordered_map<DILexicalBlock*,std::vector<DILocation*>> lexical_locs;
            std::unordered_map<DISubprogram*,std::vector<DILocation*>> subprog_locs;
            std::unordered_map<DILexicalBlock*,std::vector<DILexicalBlock*>> lexical_level;
            std::unordered_map<DISubprogram*,std::vector<DILexicalBlock*>> subprog_lexicals;
            for(Function &F:M){
                for(BasicBlock &B:F){
                    for(Instruction &I:B){
                        if(DILocation *Loc=I.getDebugLoc()){
                            unsigned Line=Loc->getLine();
                            unsigned Col=Loc->getColumn();
                            auto Scope=Loc->getScope();
                            if(DILexicalBlock *LexicalBlock=dyn_cast<DILexicalBlock>(Scope)){
                                if(lexical_locs.find(LexicalBlock)==lexical_locs.end()){
                                    lexical_locs.insert(std::make_pair(LexicalBlock,std::vector<DILocation*>()));
                                }
                                lexical_locs[LexicalBlock].push_back(Loc);
                            }else if(DISubprogram *subprog=dyn_cast<DISubprogram>(Scope)){
                                if(subprog_locs.find(subprog)==subprog_locs.end()){
                                    subprog_locs.insert(std::make_pair(subprog,std::vector<DILocation*>()));
                                }
                            }
                        }
                    }
                }
            }
            std::vector<DILexicalBlock*> lexical_blocks;
            std::vector<DISubprogram*> subprogs;
            //指令所属的词法块，可以在别的词法块范围内，搜集所以源代码行所在的词法块，构建好词法块之间的所属关系，输出json格式。
            //这里所收集到的都是源码行上一级的词法块，但是有的词法块是没有源码行的，需要向上遍历，找到缺失的词法块。
            for (const auto& lexical_loc : lexical_locs) {
                lexical_blocks.push_back(lexical_loc.first);
            }
            //每个词法块向上溯源
            for(auto lex_blk:lexical_blocks){
                auto scope=lex_blk->getScope();
                while(scope){
                    if(auto lex_blk_up=dyn_cast<DILexicalBlock>(scope)){
                        //if(lexical_blocks)
                    }
                }
            }
            for(const auto& subprog_lexicals:subprog_lexicals){
                subprogs.push_back(subprog_lexicals.first);
            }
            for(auto lexical_block:lexical_blocks){
                auto scope=lexical_block->getScope();
                if(auto lex_blk_up=dyn_cast<DILexicalBlock>(scope)){
                    if(lexical_level.find(lex_blk_up)==lexical_level.end()){
                        lexical_level.insert(std::make_pair(lex_blk_up,std::vector<DILexicalBlock*>()));
                    }
                    lexical_level[lex_blk_up].push_back(lexical_block);
                }else if(auto lex_blk_up=dyn_cast<DISubprogram>(scope)){
                    if(subprog_lexicals.find(lex_blk_up)==subprog_lexicals.end()){
                        subprog_lexicals.insert(std::make_pair(lex_blk_up,std::vector<DILexicalBlock*>()));
                    }
                    subprog_lexicals[lex_blk_up].push_back(lexical_block);
                }
            }

*/
            
            /*
            for(auto r:res){
                errs()<<r.first<<":"<<r.second<<"\n";
                f<<r.first<<":"<<r.second<<"\n";
            }
            */
            //errs()<<res.size()<<"\n";
            
            return PreservedAnalyses::all();
        }

        //收集后续可以检查的行
        void linesForDebug(DILocation* loc){
            auto scope = loc->getScope();
            //找到对应的词法作用域后，还是需要使用构建好的词法作用域信息
            if(auto lex_blk = dyn_cast<DILexicalBlock>(scope)){
                
            }
        }


        //add localscope to the hashmap
        void addScope(std::unordered_map<DILexicalBlock*,std::vector<DILexicalBlock*>> &scopeMap,DILexicalBlock *local,DILexicalBlock *outScope){
            for(auto value:scopeMap){
                if(value.first==outScope){
                    bool flag=false;
                    for(auto inner:value.second){
                        if(inner==local){
                            flag=true;
                        }
                    }
                    if(!flag){
                        value.second.push_back(local);
                    }
                }
            }
        }
        

        void collectLineInst(Module &M){
            int lastLine = -1;
            std::vector<DILexicalBlock*> vec;
            for(auto lb:vec){
                errs()<<lb->getLine()<<" "<<lb<<"\n";
            }
            for(Function &F:M){
                for (BasicBlock &BB : F)
                {
                    for (Instruction &I : BB)
                    {
                        if (isa<DbgInfoIntrinsic>(I)||isa<BranchInst>(I))
                        {
                            continue;
                        }
                        int line = 0;
                        if (auto dbgL = I.getDebugLoc())
                        {
                            if (line == dbgL->getLine())
                            {
                                //if (line > lastLine)
                                //{
                                    lineInsts.push_back(&I);
                                    lastLine=line;
                                //}
                            }
                        }
                    }
                }
            }
        }





        //get the least row
        void compareVar(std::vector<std::unique_ptr<Var>> &vars,std::unique_ptr<Var> &var2){
            bool isInclude=false;
            /*
            for(auto begin=vars.begin(),end=vars.end();begin!=end;begin++){
                auto var=*begin;
                if((*begin)->name.equals(var2->name)){
                    isInclude=true;
                    if((*begin)->line > var2->line){
                        //errs()<<" compare : "<<(*begin)->name<<" "<<(*begin)->line<<" "<<var2->line;
                        vars.pop_back();
                        vars.push_back(std::move(var2));
                        //vars.erase(begin);
                    }
                }
            }*/
        
            for(int i=0;i<vars.size();i++){
                if(vars[i]->name.data()==var2->name.data()){
                    isInclude=true;
                    if(vars[i]->line>var2->line){
                        vars.pop_back();
                        vars.push_back(std::move(var2));
                    }
                }
            }
            if(!isInclude){
                vars.push_back(std::move(var2));
            }
        }

        bool isCompute(Instruction* I){
            if(isa<BinaryOperator>(I)||isa<LoadInst>(I)||isa<CmpInst>(I)||isa<CastInst>(I)||isa<UnaryOperator>(I)||isa<BitCastInst>(I)||isa<CallInst>(I)){
                return true;
            }
            return false;
        }


        bool vecFind(const std::vector<Instruction*> &vec,Instruction* inst){
            for(Instruction* element:vec){
                if(element==inst){
                    //errs()<<"exclude inst : "<<*element<<"\n";
                    return true;
                }
            }
            return false;
        }

        Lexical* lexFind(std::vector<Lexical*> &lexicals,DILexicalBlock* l_2){
            for(auto lexical:lexicals){
                if(lexical->lex_blk==l_2){
                    return lexical;
                }
            }
            return nullptr;
        }


        static bool isRequired() { return true; }
    };
}



llvm::PassPluginLibraryInfo printInitPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "PrintInit", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager &AM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "printinit") {
                    AM.addPass(PrintInit());
                    return true;
                  }
                  return false;
                });
          }};
}

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return printInitPluginInfo();
}


#endif