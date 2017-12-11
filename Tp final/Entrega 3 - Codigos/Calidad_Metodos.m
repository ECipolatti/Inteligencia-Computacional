function [ Inter, Intra, iteraciones, tiempo, Ind_DB, Ind_Dunn, Ind_CH ] = Calidad_Metodos( k, Data )
        Inter = zeros(1,6);
        Intra = zeros(1,6);
        iteraciones = zeros(1,6);
        tiempo = zeros(1,6);
        Ind_DB = zeros(1,6);
        Ind_Dunn = zeros(1,6);
        Ind_CH = zeros(1,6);
        for i = 1: 6
            tic();
            switch i
                case 1 % BallHall
                    [ Seed ] = BallHall( k, Data );
                    disp('termino BallHall');
                case 2 % Etiquetado
                    [ Seed ] = Etiquetado( k, Data );
                    disp('Etiquetado');
                case 3 % Forgy
                    [ Seed ] = Forgy( k, Data );
                    disp('Frogy');
                case 4 % k - means++
                    [ Seed ] = k_mean_plus_plus( k, Data );
                    disp('km++');
                case 5 % Mc Queen
                    [ Seed ] = McQueen( k, Data );
                    disp('MQ');
                case 6 % Mc Rae
                    [ Seed ] = McRae( k, Data );
                    disp('MR');
            end
            time = toc();
            [ Mu, Indices, iteraciones(1,i), time_k ] = k_means( k, Data, Seed );
            tiempo(1,i) = time + time_k;
            [ Clusters ] = Clusteres( k, Data, Indices );
            [ Inter(1,i) ] = Inter_Cluster_Measure( Mu );  
            [ Intra(1,i), ICM ] = Intra_Cluster_Measure( Clusters, Mu );
            [ Ind_DB(1,i) ] = Indice_DB( Mu, ICM );
            [ Ind_Dunn(1,i) ] = Indice_Dunn( Clusters );
            [ Ind_CH(1,i) ] = Indice_CH( k, Data, Clusters, Mu);
        end

end

