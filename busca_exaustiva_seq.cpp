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
using namespace std;

tuple<vector<int>, int> escolhe_alunos(vector<vector<int>>& prefs,
                                                vector<int>& aluno_projeto, 
                                                vector<int> vagas,
                                                tuple<vector<int>, int>& melhor, 
                                                int satisfacao_atual=0,
                                                bool ja_passou = false, 
                                                int i=0){
    if(i == aluno_projeto.size()){ // todos alunos tem projeto
        if(!ja_passou){
            //cout << "Melhor:" << aluno_projeto << satisfacao_atual << "\n";
            get<0>(melhor) = aluno_projeto;
            get<1>(melhor) = satisfacao_atual;
            ja_passou = true;
            // clog << "Melhor: " << get<1>(melhor) << " ";
            // for (auto m = get<0>(melhor).begin(); m != get<0>(melhor).end(); m++){
            //     if(m+1 == get<0>(melhor).end()){
            //         clog << *m;
            //     }
            //     else{
            //         clog << *m << " ";
            //     }
            // }
            // clog << "\n";
        }
        if(satisfacao_atual > get<1>(melhor)){
            get<0>(melhor) = aluno_projeto;
            get<1>(melhor) = satisfacao_atual;
            // clog << "Melhor: " << get<1>(melhor) << " ";
            // for (auto m = get<0>(melhor).begin(); m != get<0>(melhor).end(); m++){
            //     if(m+1 == get<0>(melhor).end()){
            //         clog << *m;
            //     }
            //     else{
            //         clog << *m << " ";
            //     }
            // }
            // clog << "\n";
            ja_passou = true;
        }
        return melhor;
    }

    for(int proj_atual = 0; proj_atual < prefs[1].size(); proj_atual++){
        if (vagas[proj_atual] > 0){ // projeto prefs[j] tem vaga!
            vagas[proj_atual] -= 1;
            aluno_projeto[i] = proj_atual;

            melhor = escolhe_alunos(prefs, aluno_projeto, vagas, melhor, satisfacao_atual + prefs[i][ proj_atual], ja_passou, i+1);

            aluno_projeto[i] = -1;
            vagas[proj_atual] += 1;
            ja_passou = true;
        }
    }
    return melhor;
}

int main() {
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
    vector<int> aluno_projeto(n_alunos, -1);

    tuple<vector<int>, int> melhor;
    melhor = escolhe_alunos(prefs, aluno_projeto, vagas, melhor);

    cout << get<1>(melhor) << " 1\n";
    for (auto m = get<0>(melhor).begin(); m != get<0>(melhor).end(); m++){
        if(m+1 == get<0>(melhor).end()){
            cout << *m;
        }
        else{
            cout << *m << " ";
        }
    }
    cout << "\n";
}