cmake_minimum_required(VERSION 3.12)
project (projetoFinal LANGUAGES CXX CUDA)
find_package(OpenMP)
find_package(CUDA QUIET REQUIRED)

add_executable(busca_exaustiva_seq busca_exaustiva_seq.cpp)
target_compile_options(busca_exaustiva_seq PUBLIC -O3)

add_executable(busca_exaustiva_par busca_exaustiva_par.cpp)
target_compile_options(busca_exaustiva_par PUBLIC -O3)
target_link_libraries(busca_exaustiva_par PUBLIC OpenMP::OpenMP_CXX)


add_executable(branch_and_bound_seq branch_and_bound_seq.cpp)
target_compile_options(branch_and_bound_seq PUBLIC -O3)

add_executable(branch_and_bound_par branch_and_bound_par.cpp)
target_compile_options(branch_and_bound_par PUBLIC -O3)
target_link_libraries(branch_and_bound_par PUBLIC OpenMP::OpenMP_CXX)


add_executable(busca_local_seq busca_local_seq.cpp)
target_compile_options(busca_local_seq PUBLIC -O3)

add_executable(busca_local_par busca_local_par.cpp)
target_compile_options(busca_local_par PUBLIC -O3)
target_link_libraries(busca_local_par PUBLIC OpenMP::OpenMP_CXX)

cuda_add_executable(busca_gpu busca_local.cu OPTIONS -std=c++11)
