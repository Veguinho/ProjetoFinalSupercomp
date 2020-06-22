#include <iostream>
#include <cmath>
#include <ctime>
#include <vector>
#include <chrono>
#include <functional>
#include <fstream>
#include <algorithm>
#include <sstream>
#include <string>
#include <random>
using namespace std;

void random_alunos_dist(vector<int>& aluno_projeto, vector<int> vagas, default_random_engine& generator){

    for (int proj = 0; proj < vagas.size(); proj++){
        while(vagas[proj]>0){
            aluno_projeto.push_back(proj);
            vagas[proj] -=1;
        }
    }
    shuffle(begin(aluno_projeto), end(aluno_projeto), generator);
}

int calc_satisfacao_atual(vector<vector<int>>& prefs, vector<int>& aluno_projeto){
    int satisfacao_atual = 0;
    for(auto aluno_atual = 0; aluno_atual < aluno_projeto.size(); aluno_atual++){
        satisfacao_atual += prefs[aluno_atual][aluno_projeto[aluno_atual]];
    }
    return satisfacao_atual;
}

void escolhe_alunos(vector<vector<int>>& prefs,vector<int>& aluno_projeto, int satisfacao_atual){
    bool flag = true;
    while(flag){
        flag = false;
        for(auto i=0; i < aluno_projeto.size(); i++){
            for(auto j=0; j < aluno_projeto.size(); j++){
                vector<int> temp = aluno_projeto;
                if(j>i){
                    swap(temp[i], temp[j]);
                }
                int satisfacao_temp = calc_satisfacao_atual(prefs, temp);
                if (satisfacao_temp > satisfacao_atual){
                    satisfacao_atual = satisfacao_temp;
                    aluno_projeto = temp;
                    flag = true;
                    // clog << "Iteracao " << satisfacao_atual << " ";
                    // for (auto m = aluno_projeto.begin(); m != aluno_projeto.end(); m++){
                    //     if(m+1 == aluno_projeto.end()){
                    //         clog << *m;
                    //     }
                    //     else{
                    //         clog << *m << " ";
                    //     }
                    // }
                    // clog << "\n";
                }
            }
        }
    }
}

int main(){
    string line;
	vector<int> v_entrada;
    int tmp_op;
    getline(cin, line);
    istringstream ss(line);

    while(ss >> tmp_op){
        v_entrada.push_back(tmp_op);
    }
    int n_alunos, n_projetos, n_choices;
    n_alunos = v_entrada[0];
    n_projetos =  v_entrada[1];
    n_choices = v_entrada[2];

    vector<vector<int>> prefs(n_alunos, vector<int>(n_projetos));
    vector<int> projs;
    int proj_tmp;
 
    int seed = 0;
    int iter = 100000;
    if(getenv("SEED")){
        seed = atoi(getenv("SEED"));
    }
    if(getenv("ITER")){
        iter = atoi(getenv("ITER"));
    }

    for (int i=0; i<n_alunos; i++){       
        getline(cin, line);
        istringstream ss(line);
        projs.clear();
        while(ss >> proj_tmp) {
            projs.push_back(proj_tmp);
        }
        for(int j = 0; j < n_choices; j++){           
            prefs[i][projs[j]] = pow(n_choices-j,2);
        }
    }

    vector<int> vagas(n_projetos, 3);
    tuple<vector<int>, int> melhor;
    int satisfacao_atual_geral;
    vector<int> aluno_projeto_geral;

    default_random_engine generator(seed);

    for(int i=0; i < iter; i++){
        vector<int> aluno_projeto;
        random_alunos_dist(aluno_projeto, vagas, generator);
        int satisfacao_atual_local = calc_satisfacao_atual(prefs, aluno_projeto);

        // clog << "Inicial " << satisfacao_atual_local << " ";
        // for (auto m = aluno_projeto.begin(); m != aluno_projeto.end(); m++){
        //     if(m+1 == aluno_projeto.end()){
        //         clog << *m;
        //     }
        //     else{
        //         clog << *m << " ";
        //     }
        // }
        // clog << "\n";

        escolhe_alunos(prefs, aluno_projeto, satisfacao_atual_local);

        satisfacao_atual_local = calc_satisfacao_atual(prefs, aluno_projeto);

        if(satisfacao_atual_local > satisfacao_atual_geral)
        {
            satisfacao_atual_geral = satisfacao_atual_local;  
            aluno_projeto_geral = aluno_projeto;
        }
    }

    get<1>(melhor) = satisfacao_atual_geral;
    get<0>(melhor) = aluno_projeto_geral;
    cout << get<1>(melhor) << " 0\n";
    for (auto m = get<0>(melhor).begin(); m != get<0>(melhor).end(); m++){
        cout << *m << " ";
    }
    cout << "\n";
}