% Nube Numero 1:
N = 770;                     % Number of points
V = [-5, 4; -4, 6; 3, -4];  % Triangle vertices, pairs of (x, y)
t = sqrt(rand(N, 1));
s = rand(N, 1);
nube1 = (1 - t) * V(1, :) + bsxfun(@times, ((1 - s) * V(2, :) + s * V(3, :)), t);

% Nube Numero 2:
N = 350;                     % Number of points
V = [-1, 3; 0, 5; 1, 3];    % Triangle vertices, pairs of (x, y)
t = sqrt(rand(N, 1));
s = rand(N, 1);
nube2 = (1 - t) * V(1, :) + bsxfun(@times, ((1 - s) * V(2, :) + s * V(3, :)), t);

% Nube Numero 3:
N = 600;                     % Number of points
V = [3, 4; 4, 6; 5, 4];     % Triangle vertices, pairs of (x, y)
t = sqrt(rand(N, 1));
s = rand(N, 1);
nube3 = (1 - t) * V(1, :) + bsxfun(@times, ((1 - s) * V(2, :) + s * V(3, :)), t);

% Nube Numero 4:
N = 480;                     % Number of points
V = [-6, -1; -5, 1; -4, -1]; % Triangle vertices, pairs of (x, y)
t = sqrt(rand(N, 1));
s = rand(N, 1);
nube4 = (1 - t) * V(1, :) + bsxfun(@times, ((1 - s) * V(2, :) + s * V(3, :)), t);

% Nube Numero 5:
N = 900;                     % Number of points
V = [-1, -1; 0, 1; 1, -1];  % Triangle vertices, pairs of (x, y)
t = sqrt(rand(N, 1));
s = rand(N, 1);
nube5 = (1 - t) * V(1, :) + bsxfun(@times, ((1 - s) * V(2, :) + s * V(3, :)), t);

% Nube Numero 6:
N = 900;                     % Number of points
V = [1, -3; 5, 1; 6, -1];   % Triangle vertices, pairs of (x, y)
t = sqrt(rand(N, 1));
s = rand(N, 1);
nube6 = (1 - t) * V(1, :) + bsxfun(@times, ((1 - s) * V(2, :) + s * V(3, :)), t);

% Nube Numero 7:
N = 900;                         % Number of points
V = [-5, -6; -5, -0; -3, -6];   % Triangle vertices, pairs of (x, y)
t = sqrt(rand(N, 1));
s = rand(N, 1);
nube7 = (1 - t) * V(1, :) + bsxfun(@times, ((1 - s) * V(2, :) + s * V(3, :)), t);

% Nube Numero 8:
N = 900;                         % Number of points
V = [-1, -5; 0, -3; 1, -5];     % Triangle vertices, pairs of (x, y)
t = sqrt(rand(N, 1));
s = rand(N, 1);
nube8 = (1 - t) * V(1, :) + bsxfun(@times, ((1 - s) * V(2, :) + s * V(3, :)), t);

% Nube Numero 9:
N = 900;                     % Number of points
V = [-5, -10; 4, -4; 5, -6];     % Triangle vertices, pairs of (x, y)
t = sqrt(rand(N, 1));
s = rand(N, 1);
nube9 = (1 - t) * V(1, :) + bsxfun(@times, ((1 - s) * V(2, :) + s * V(3, :)), t);


Data = [nube1 ; nube2; nube3; nube4; nube5 ; nube6; nube7; nube8; nube9];
Data= [Data Data Data];
csvwrite('Triangulos_9_6D', Data);
% scatter(Data(:,1), Data(:,2),'r','.');
% hold on;
