GROUP=($(./FIRESTARTER --list-instruction-groups | tail -n 1))
./FIRESTARTER --run-instruction-groups $GROUP