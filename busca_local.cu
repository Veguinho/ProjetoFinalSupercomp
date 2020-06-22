#include <iostream>
#include <cmath>
#include <vector>
#include <functional>
#include <fstream>
#include <algorithm>
#include <sstream>
#include <string>
#include <random>
#include <thrust/random.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <thrust/random/linear_congruential_engine.h>
#include <thrust/random/uniform_int_distribution.h>
using namespace std;

int calc_satisfacao_atual(vector<vector<int>>& prefs, vector<int>& aluno_projeto){
    int satisfacao_atual = 0;
    for(auto aluno_atual = 0; aluno_atual < aluno_projeto.size(); aluno_atual++){
        satisfacao_atual += prefs[aluno_atual][aluno_projeto[aluno_atual]];
    }
    return satisfacao_atual;
}

struct escolhe_alunos{
    int *prefs;
    int *aluno_projeto;
    int n_alunos;
    int n_projetos;
    int seed;
    thrust::uniform_int_distribution<int> dist;
    
    escolhe_alunos (int *prefs, int *aluno_projeto, int n_alunos, int n_projetos, int seed, 
                    thrust::uniform_int_distribution<int> dist) : prefs(prefs), 
                                                                  aluno_projeto(aluno_projeto),
                                                                  n_alunos(n_alunos),
                                                                  n_projetos(n_projetos),
                                                                  seed(seed),
                                                                  dist(dist){};

    __device__ __host__
    int operator()(const int &i) {;

    int random_int;
    thrust::default_random_engine rng(i+seed);
    rng.discard(i);

    int tmp1;
    for(int k=0; k < n_alunos; k++){
        random_int = dist(rng);
        tmp1 = aluno_projeto[k+i*n_alunos];
        aluno_projeto[k+i*n_alunos] = aluno_projeto[random_int+i*n_alunos]; //faz trocas no aluno projeto aleatoriamente
        aluno_projeto[random_int+i*n_alunos] = tmp1;
    }
    
    int satisfacao_local = 0;
    bool flag = true;

    //calcula satisfacao
    for(int c=0; c < n_alunos; c++){
        satisfacao_local += prefs[c*n_projetos+aluno_projeto[c+i*n_alunos]];
    }
    
    while(flag){
        flag = false;
        for(int a=0; a < n_alunos; a++){
            for(int b=0; b < n_alunos; b++){
                if(b>a){
                    int satisfacao_tmp = 0;
                    tmp1 = aluno_projeto[a+i*n_alunos];
                    aluno_projeto[a+i*n_alunos] = aluno_projeto[b+i*n_alunos]; //faz trocas no aluno projeto
                    aluno_projeto[b+i*n_alunos] = tmp1;

                    //calcula satisfacao
                    for(int c=0; c < n_alunos; c++){
                        satisfacao_tmp += prefs[c*n_projetos+aluno_projeto[c+i*n_alunos]];
                    }

                    if(satisfacao_tmp > satisfacao_local){
                        satisfacao_local = satisfacao_tmp;
                        flag = true;
                    }
                    else{
                        tmp1 = aluno_projeto[a+i*n_alunos];
                        aluno_projeto[a+i*n_alunos] = aluno_projeto[b+i*n_alunos]; //destroca no aluno projeto
                        aluno_projeto[b+i*n_alunos] = tmp1;
                    }
                }
            }
        }
    }
    return satisfacao_local;
  }  
};

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

    vector<int> prefs(n_alunos*n_projetos);
    vector<int> projs;
    int proj_tmp;
 
    int seed = 0;
    int iterations = 100000;
    if(getenv("SEED")){
        seed = atoi(getenv("SEED"));
    }
    if(getenv("ITER")){
        iterations = atoi(getenv("ITER"));
    }

    for (int i=0; i<n_alunos; i++){       
        getline(cin, line);
        istringstream ss(line);
        projs.clear();
        while(ss >> proj_tmp){
            projs.push_back(proj_tmp);
        }
        for(int j = 0; j < n_choices; j++){     
            prefs[n_projetos*i+projs[j]] = pow(n_choices-j,2);
        }
    }
    
    vector<int> aluno_projeto_vector;
    //preenche aluno_projeto em ordem 0,0,0,1,1,1,2,2,2...
    for(int i=0; i<iterations; i++){
        vector<int> vagas(n_projetos,3);
        for (int proj = 0; proj < vagas.size(); proj++){
            while(vagas[proj]>0){
                aluno_projeto_vector.push_back(proj);
                vagas[proj] -=1;
            }
        }
    }

    thrust::uniform_int_distribution<int> dist(0,n_alunos-1);
    //Fazer um vetor gigante com varios vetores aleatorios contidos dentro dele
    //Passar esse vetor gigante no lugar deste "dist" abaixo
    thrust::host_vector<int> aluno_projeto_cpu(aluno_projeto_vector);
    thrust::host_vector<int> satisfacao_atual_cpu(iterations,-1);

    thrust::device_vector<int> satisfacao_atual_gpu(satisfacao_atual_cpu);
    thrust::device_vector<int> aluno_projeto_gpu(aluno_projeto_cpu);
    thrust::device_vector<int> prefs_gpu(prefs);

    escolhe_alunos calc_satisfac(thrust::raw_pointer_cast(prefs_gpu.data()),
                                thrust::raw_pointer_cast(aluno_projeto_gpu.data()),
                                n_alunos,
                                n_projetos,
                                seed,
                                dist);

    thrust::counting_iterator<int> iterator(0);
    thrust::transform(iterator, iterator+(iterations), satisfacao_atual_gpu.begin(), calc_satisfac);

    int index = 0;
    int best_index = 0;
    int best_result = 0;
    for (auto m = satisfacao_atual_gpu.begin(); m != satisfacao_atual_gpu.end(); m++){
        if(*m > best_result){
            best_result = *m;
            best_index = index;
        }
        index++;
    }

    cout << best_result << " 0\n";
    for (int m = best_index*n_alunos; m < (best_index+1)*n_alunos; m++){
        cout << aluno_projeto_gpu[m] << " ";
    }
    cout << "\n";
}